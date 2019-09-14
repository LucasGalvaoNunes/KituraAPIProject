//
//  Persistence.swift
//  Application
//
//  Created by PUCPR on 14/09/19.
//

import Foundation
import SwiftKueryORM
import SwiftKueryPostgreSQL
import LoggerAPI

class Persistence {
    static func setUp(){
        let pool = PostgreSQLConnection.createPool(
            host:ProcessInfo.processInfo.environment["DBHOST"] ?? "localhost",
            port: 5432,
            options: [
                .databaseName("notes"),
                .userName(
            ProcessInfo.processInfo.environment["DBUSER"] ?? "postgres" 
                ),
                .password(
            ProcessInfo.processInfo.environment["DBPASSWORD"] ?? "Lucas"
                )
            ],
            poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50, timeout: 10000)
        )
        Database.default = Database(pool)
        do{
            try NoteEntry.createTableSync()
        }catch let error{
            if let requestError = error as? RequestError,
                requestError.rawValue == RequestError.ormQueryError.rawValue
                {
                Log.info("\(NoteEntry.tableName) já existe")
            }else{
                Log.error(String(describing: error))
            }
        }
    }
}
