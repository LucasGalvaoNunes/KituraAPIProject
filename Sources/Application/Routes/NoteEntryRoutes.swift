//
//  NoteEntryRoutes.swift
//  Application
//
//  Created by PUCPR on 14/09/19.
//

import Foundation
import LoggerAPI
import Kitura
import SwiftKueryORM
import SwiftKueryPostgreSQL
import SwiftKuery


func initializeNoteEntryRoutes(app:App){
    app.router.post("/entries",handler: addEntry)
    app.router.get("/entries",handler: getEntries)
    app.router.delete("/entries", handler: deleteEntry)
    app.router.put("/entries",handler: modifyEntry)
    app.router.get("/entries",handler: getOneEntry)
}
func addEntry(entry:NoteEntry,completion:
    @escaping(NoteEntry?,RequestError?) -> Void){
    var storedEntry = entry
    storedEntry.id = UUID().uuidString
    storedEntry.save(completion)
}
func getEntries(params:NoteEntryParams?,completion:
    @escaping ([NoteEntry]?,RequestError?)->Void)->Void{
    NoteEntry.findAll(matching:params,completion)
}
func deleteEntry(id:String,completion:
    @escaping (RequestError?)->Void){
    NoteEntry.delete(id:id,completion)
}
func modifyEntry(id:String,entry:NoteEntry,completion:
    @escaping(NoteEntry?,RequestError?) -> Void){
    entry.update(id:id,completion)
}
func getOneEntry(id:String,completion:
    @escaping(NoteEntry?,RequestError?) -> Void){
    NoteEntry.find(id: id, completion)
}
