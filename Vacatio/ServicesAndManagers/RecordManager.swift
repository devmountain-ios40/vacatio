//
//  RecordManager.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import CloudKit

class RecordManager<S: StorageProtocol, R: RecordProtocol> {
    typealias StorageService = S
    typealias Record = R
    
    private(set) var storageService: StorageService?
    private(set) var record: Record?
    
    init(storageService: StorageService) {
        self.storageService = storageService
    }

    func subscribeToRecordUpdates(recordType: String, container: CKContainer) {
        guard let storageService = storageService else { return }
        container.accountStatus { accountStatus, error in
            if let error = error {
                print(error)
            }
            if accountStatus == CKAccountStatus.available {
                storageService.subscribeToRecordUpdates(recordType: recordType)
            }
        }
    }
    
    func addNotificationObserver(notificationName: Notification.Name, recordName: String) {
        // Registers a global observer that fires when the config is updated.
        NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: nil) { notification in
            // TODO: Do we need this next line?
            //guard let strongSelf = self else { return }
            self.fetch(record: recordName)
        }
    }
    
    func fetch(record recordName: String) {
        guard let storageService = storageService else { return }
        storageService.fetch(record: recordName) { result in
            switch result {
                case .success(let record):
                    print("🔑 Fetched \(type(of: record))")
                    self.record = record as? Record
                case .failure(let error):
                    // TODO: Notify developer of error.
                    print(error)
            }
        }
    }
}
