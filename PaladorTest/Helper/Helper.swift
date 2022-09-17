//
//  Helper.swift
//  PaladorTest
//
//  Created by Yudha on 14/09/22.
//

import Foundation

class Helper {
    static let shared = Helper()
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func parse<T: Decodable>(model: T.Type, jsonData: Data) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("decode error")
            print(error)
        }
        
        return nil
    }
}
