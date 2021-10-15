//
//  ConfigController.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import CloudKit

// Got this pattern from here: https://medium.com/@hartwellalex/protocol-extensions-and-shared-dependency-injection-in-swift-an-alternative-to-singletons-68934dee6998
protocol ConfigControllerInjector {
    func configController(containerIdentifier: String) -> ConfigController
}

fileprivate func sharedConfigController(containerIdentifier: String) -> ConfigController {
    let container = CKContainer(identifier: containerIdentifier)
    let database = container.publicCloudDatabase
    let cloudKitService = CloudKitService(database: database)
    let recordManager = RecordManager<CloudKitService, Config>(storageService: cloudKitService)
    recordManager.subscribeToRecordUpdates(recordType: "\(Config.self)", container: container)
    recordManager.fetch(record: "\(Config.self)")
    recordManager.addNotificationObserver(notificationName: .configUpdated, recordName: "\(Config.self)")
    return ConfigController(recordController: recordManager)
}

extension ConfigControllerInjector {
    @discardableResult
    func configController(containerIdentifier: String = Environment.cloudKitContainer) -> ConfigController {
        return sharedConfigController(containerIdentifier: containerIdentifier)
    }
}

class ConfigController {
    typealias CKRecordController = RecordManager<CloudKitService, Config>

    private(set) var recordController: CKRecordController?
    
    var config: Config? {
        return recordController?.record
    }
    
    private init() {}
    
    init(recordController: CKRecordController) {
        self.recordController = recordController
    }
}
//    recordController.subscribeToRecordUpdates(recordType: "\(Config.self)", container: container)
//    recordController.addNotificationObserver(notificationName: .configUpdated, recordName: "\(Config.self)")
