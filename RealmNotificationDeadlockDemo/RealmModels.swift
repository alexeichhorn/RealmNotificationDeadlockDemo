//
//  RealmModels.swift
//  RealmNotificationDeadlockDemo
//
//  Created by Alexander Eichhorn on 25.03.22.
//

import Foundation
import RealmSwift

class Dog: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
}

class Person: Object {
    @Persisted(primaryKey: true) var name: String
}
