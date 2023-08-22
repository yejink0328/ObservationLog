//
//  Log.swift
//  ObservationLog
//
//  Created by MAX on 2023/08/21.
//

import Foundation

struct Log: Identifiable {
    let id: UUID
    var logName: String
    var theme: Theme
    var logDate: Date
    var memos: [String]
}
