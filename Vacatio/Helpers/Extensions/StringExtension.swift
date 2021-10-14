//
//  StringExtension.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import Foundation

extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespaces)
        let tmpstr = components.filter { !$0.isEmpty }.joined(separator: " ")
        let components2 = tmpstr.components(separatedBy: .newlines)
        return components2.filter { !$0.isEmpty }.joined(separator: "\n")
    }
}
