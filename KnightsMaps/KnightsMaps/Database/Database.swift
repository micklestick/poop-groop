//
//  database.swift
//  KnightsMaps
//
//  Created by Isaac Vaughn on 2/19/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import Foundation
import MongoSwift
import mongoc

protocol Database {
    func get<T: Codable>(_ collection: String, _ identifier: String) throws -> T
    func put<T: Codable>(_ collection: String, _ document: T) throws
    func newCollection(_ collection: String) throws
}

class KMDatabase: Database {
    private var client: MongoClient
    private var database: MongoDatabase
    
    init() throws {
        MongoSwift.initialize()
//        self.client = try! MongoClient(connectionString: "mongodb://localhost:27017")
        // SSL doesn't work on iOS.
        self.client = try! MongoClient(connectionString: "mongodb+srv://developer:Praeparet_Bellum@knightsmapsdatabase-bg2m3.mongodb.net/?ssl=false")
        self.database = try! client.db("KnightsMapsDatabase")
    }

    deinit {
        MongoSwift.cleanup()
    }

    func get<T: Codable>(_ collection: String, _ identifier: String) throws -> T {
        let collection: MongoCollection<T> = try self.database.collection(collection, withType: T.self, options: nil)
        let query: Document = ["id": identifier]
        let options: FindOptions = FindOptions(limit: 1)
        return try collection.find(query, options: options).nextOrError()!
    }

    func put<T: Codable>(_ collection: String, _ document: T) throws {
        let collection: MongoCollection<T> = try self.database.collection(collection, withType: T.self, options: nil)
        try collection.insertOne(document)
    }

    func newCollection(_ collection: String) throws {
        _ = try self.database.createCollection(collection)
    }

}
