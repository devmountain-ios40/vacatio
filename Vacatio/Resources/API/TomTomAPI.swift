//
//  TomTomAPI.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 9/30/21.
//

import Foundation

// MARK: - Welcome
struct TopLevelObject: Codable {
    let summary: Summary
    let results: [SearchResult]
}

// MARK: - Result
struct SearchResult: Codable  {
    let type: String
    let id: String
    let score, dist: Double
    let info: String //Do we need this?
    let poi: Poi
    let address: Address
    let position: Position
    let entryPoints: [EntryPoint]
    let dataSources: DataSources?
}

// MARK: - Position
struct Position: Codable {
    let lat, lon: Double
}
// MARK: - Poi
struct Poi: Codable {
    let name: String
    let phone: String?
    let categorySet: [CategorySet]
    let categories: [String]
    let classifications: [Classification]
    let brands: [Brand]?
    let url: String?
}

// MARK: - Address
struct Address: Codable  {
    let postalCode: String?
    let countryCodeISO3: String?
    let freeformAddress: String
    let localName: String?
}

// MARK: - DataSources
struct DataSources: Codable {
    let poiDetails: [PoiDetail]?
}

// MARK: - PoiDetail
struct PoiDetail: Codable  {
    let id, sourceName: String
}

// MARK: - EntryPoint
struct EntryPoint: Codable  {
    let type: String
    let position: Position
}

// MARK: - Brand
struct Brand: Codable  {
    let name: String
}

// MARK: - CategorySet
struct CategorySet: Codable  {
    let id: Int
}

// MARK: - Classification
struct Classification: Codable  {
    let code: String
    let names: [Name]
}

// MARK: - Name
struct Name: Codable  {
    let nameLocale: String
    let name: String
}

// MARK: - Summary
struct Summary: Codable  {
    let queryType: String
    let queryTime, numResults, offset, totalResults: Int
    let fuzzyLevel: Int
    let geoBias: GeoBias
}
// MARK: - GeoBias
struct GeoBias: Codable  {
    let lat, lon: Double
}
