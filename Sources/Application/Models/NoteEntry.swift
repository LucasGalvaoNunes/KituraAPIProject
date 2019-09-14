//
//  NoteEntry.swift
//  Application
//
//  Created by PUCPR on 14/09/19.
//

import Foundation
import KituraContracts
import SwiftKueryORM;

struct NoteEntryParams:QueryParams{
    var label:String?
}

struct NoteEntry:Model{
    var id:String?
    var text:String
    var label:String
    var date:Date
}
