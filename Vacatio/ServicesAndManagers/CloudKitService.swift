//
//  CloudKitService.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import CloudKit

class CloudKitService: StorageProtocol {
    typealias RecordProtocol = Config
    typealias RecordError = CloudKitError
    
    private var database: CKDatabase?
    private var dispatchQueue = DispatchQueue(label: "CloudKitService.queue.identifier")
    
    init(database: CKDatabase) {
        dispatchQueue.sync {
            self.database = database
        }
    }
    
    // TODO: Is there any thing left to do here?
    // This might be a decent guide to read through: https://www.rambo.codes/posts/2020-02-25-cloudkit-101
    func subscribeToRecordUpdates(recordType: String) {
        guard let database = database else { return }
        guard !UserDefaults.standard.bool(forKey: "\(recordType)-didCreateQuerySubscription") else { return }

        let predicate = NSPredicate(value: true)

        // Create a subscription and scope it to the record type.
        // Provide a unique identifier for the subscription and declare the circumstances for invoking it.
        let subscription = CKQuerySubscription(recordType: recordType,
                                               predicate: predicate,
                                               subscriptionID: "\(recordType)-subscriptionID",
                                               options: .firesOnRecordUpdate)

        // Configure the notification so that the system delivers it silently and, therefore,
        // doesn't require permission from the user.
        let notificationInfo = CKSubscription.NotificationInfo()
        notificationInfo.shouldSendContentAvailable = true
        subscription.notificationInfo = notificationInfo

        // Assign the subscription to an operation.
        let operation = CKModifySubscriptionsOperation(subscriptionsToSave: [subscription],
                                                       subscriptionIDsToDelete: nil)

        operation.modifySubscriptionsCompletionBlock = { subscriptions, deleted, error in
            if let ckError = error as? CKError {
                switch ckError {
                    case CKError.requestRateLimited,
                        CKError.serviceUnavailable,
                        CKError.networkUnavailable,
                        CKError.networkFailure,
                        CKError.zoneBusy:
                        let retryAfterSeconds = ckError.retryAfterSeconds ?? 3.0
                        let deadline = DispatchTime.now() + retryAfterSeconds
                        DispatchQueue.global().asyncAfter(deadline: deadline, execute: {
                            self.subscribeToRecordUpdates(recordType: recordType)
                        })
                    default:
                        break
                }
                return
            }

            // Record that the system successfully creates the subscription to prevent
            // unnecessary trips to the server in later launches.
            UserDefaults.standard.setValue(true, forKey: "\(recordType)-didCreateQuerySubscription")
        }

        // Set an appropriate QoS and add the operation to the public database's operation
        // queue to execute it.
        operation.qualityOfService = .utility
        database.add(operation)
    }
    
    func fetch(record recordName: String, completion: @escaping Handler) {
        guard let database = database else { return }
        let ckRecordID = CKRecord.ID(recordName: recordName)
        database.fetch(withRecordID: ckRecordID) { record, error in
            if let ckError = error as? CKError {
                switch ckError {
                    case CKError.requestRateLimited, CKError.serviceUnavailable, CKError.zoneBusy:
                        let retryAfterSeconds = ckError.retryAfterSeconds ?? 3.0
                        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + retryAfterSeconds, execute: {
                            self.fetch(record: recordName, completion: completion)
                        })
                    default:
                        completion(.failure(.ckError(ckError)))
                }
                return
            }

            guard let record = record else {
                return completion(.failure(.couldNotUnwrap))
            }

            guard let config = Config(record: record) else {
                return completion(.failure(.noConfig))
            }
            
            completion(.success(config))
        }
    }
}
