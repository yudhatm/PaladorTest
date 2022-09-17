//
//  UserDefaultManager.swift
//  PaladorTest
//
//  Created by Yudha on 14/09/22.
//

import Foundation

class UserDefaultManager {
    static var shared = UserDefaultManager()
    
    let userDefault = UserDefaults.standard
    
    func saveObject(_ object: Any, key: String) {
        userDefault.set(object, forKey: key)
        print("[UserDefaultManager] Object \(key) is saved")
    }
    
    func loadObject(key: String) -> Any? {
        guard let data = userDefault.object(forKey: key) else {
            print("[UserDefaultManager] ERROR: Load object with key \(key) failed")
            return nil
        }
        
        return data
    }
    
    func loadDataObject(key: String) -> Data? {
        guard let data = userDefault.data(forKey: key) else {
            print("[UserDefaultManager] ERROR: Load object with key \(key) failed")
            return nil
        }
        
        return data
    }
    
    func removeObject(key: String) {
        userDefault.removeObject(forKey: key)
        print("[UserDefaultManager] Object \(key) is removed")
    }
}
