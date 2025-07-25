//
//  UserDefaultsManager.swift
//  Millionaire
//
//  Created by Варвара Уткина on 25.07.2025.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    // MARK: - Private Properties
    private let userDefaults: UserDefaults
    private let userKey = "userKey"
    
    // MARK: - Initializers
    private init() {
        userDefaults = UserDefaults.standard
    }
    
    // MARK: - CRUD
    func getUser() -> User? {
        guard let data = userDefaults.data(forKey: userKey) else {
            return nil
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            print("Ошибка при чтении пользователя пользователя (UserDefaults)")
            return nil
        }
    }
    
    func createUser() {
        let user = User()
        saveUser(user)
    }
    
    func saveUser(_ user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            userDefaults.set(data, forKey: userKey)
        } catch {
            print("Ошибка при обновлении пользователя (UserDefaults)")
        }
    }
}
