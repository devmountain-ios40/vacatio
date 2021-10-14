//
//  RecordProtocol.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import Foundation

protocol RecordProtocol {
    associatedtype Record
    var record: Record? { get set }
    init()
    init?(record: Record)
}
