//
//  BackgroundListener.swift
//  RealmNotificationDeadlockDemo
//
//  Created by Alexander Eichhorn on 25.03.22.
//

import Foundation
import RealmSwift

class BackgroundListener {
    
    static let shared = BackgroundListener()
    
    private var notificationTokens = Set<NotificationToken>()
    
    private let queue = DispatchQueue(label: "listenerQueue", qos: .userInitiated)
    
    func startListening() {
        
        guard notificationTokens.isEmpty else { return }
        
        addStartingObjects()
        
        let realm = try! Realm()
        
        notificationTokens.insert(realm.objects(Dog.self).observe(on: queue) { [unowned self] changes in
            switch changes {
            case .initial(let results):
                for dog in results {
                    updateDogName(dog)
                }
                
            default: break
            }
        })
        
        notificationTokens.insert(realm.objects(Person.self).observe(on: queue) { [unowned self] changes in
            switch changes {
            case .initial(let results):
                updateAllPersonNames()
                
            default: break
            }
        })
    }
    
    private func updateDogName(_ dog: Dog) {
        
        let realm = try! dog.realm ?? Realm()
        
        print("dog write started")
        
        precondition(!realm.isInWriteTransaction)
        
        try! realm.write {
            dog.name += "z"
        }
        print("dog write finished")
    }
    
    private func updateAllPersonNames() {
        
        let realm = try! Realm()
        
        print("person write started")
        
        precondition(!realm.isInWriteTransaction)
        
        let persons = realm.objects(Person.self)
        
        try! realm.write {
            for person in persons {
                person.name += "p"
            }
        }
        print("person write finished")
    }
    
    /*private func updatePersonName(_ person: Person) {
        
        let realm = try! Realm()
        
        print("person write started")
        
        precondition(!realm.isInWriteTransaction)
        
        try! realm.write {
            person.name += "p"
        }
        print("person write finished")
    }*/
    
    // MARK: -
    
    private func addStartingObjects() {
        
        let realm = try! Realm()
        
        if realm.objects(Dog.self).isEmpty {
            try! realm.write {
                let dog = Dog()
                dog.id = 123
                dog.name = "Dodo"
                realm.add(dog)
            }
        }
        
        if realm.objects(Person.self).isEmpty {
            try! realm.write {
                let person = Person()
                person.name = "Dave"
                realm.add(person)
            }
        }
        
    }
    
}
