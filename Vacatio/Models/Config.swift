//
//  Config.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import CloudKit

struct Config: RecordProtocol {
    fileprivate static let tomtomApiKeyKey = "tomtomApiKey"
    fileprivate static let tomtomApiUrlKey = "tomtomApiUrl"
    
    var record: CKRecord?
    
    init() {}
    
    init?(record: CKRecord) {
        self.record = record
    }
    
    var tomtomApiKey: String {
        guard let record = record else { return "" }
        return record.value(forKey: Config.tomtomApiKeyKey, defaultValue: "")
    }
    
    var tomtomApiUrl: URL? {
        guard let record = record else { return nil }
        let value = record.value(forKey: Config.tomtomApiUrlKey, defaultValue: "")
        return URL(string: value)
    }
}

extension CKRecord {
    func value(forKey key: String, defaultValue: @autoclosure () -> String) -> String {
        guard let value = self[key] as? String else {
            return defaultValue()
        }
        return value
    }
}
