//
//  PersistanceManager.swift
//  QuizApp
//
//  Created by Marek Srutka on 02.03.2024.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    
    static let defaults = UserDefaults.standard
    
    enum Keys { static let nickname = "username" }
    
    static func deleteUser() {
        defaults.removeObject(forKey: Keys.nickname)
    }
    
    static func doesUserExist() -> Bool {
        return defaults.object(forKey: Keys.nickname) != nil
    }
    
    static func retrieveUser() -> User {
        guard let userData = defaults.object(forKey: Keys.nickname) as? Data else {
            return User(username: "")
        }

        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: userData)
            return user
        } catch {
            return User(username: "")
        }
    }

    static func saveUser(_ user: User) {
         do {
             let encoder = JSONEncoder()
             let encodedData = try encoder.encode(user)
             defaults.set(encodedData, forKey: Keys.nickname)
         } catch {
             print("Chyba při kódování uživatele: \(error)")
         }
     }
}
