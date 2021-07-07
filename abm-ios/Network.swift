//
//  Network.swift
//  abm-ios
//
//  Created by Matthew Farmer on 7/6/21.
//

import Foundation

class Network {
    
    func getSkills(completion: @escaping (Result<[Skill], Error>) -> Void) {
        guard let url = URL(string: "https://appsbymatthew-api-v5omtve52a-uc.a.run.app/api/skills") else {
            print("Invalid URL!"); return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
                return
            }
            
            do {
                let skills = try! JSONDecoder().decode([Skill].self, from: data!)
                completion(.success(skills))
            } catch let jsonError {
                completion(.failure(jsonError.localizedDescription as! Error))
            }
        }.resume()
    }
    
    func getApplications(completion: @escaping (Result<[Application], Error>) -> Void) {
        guard let url = URL(string: "https://appsbymatthew-api-v5omtve52a-uc.a.run.app/api/applications?limit=999&skip=0&") else {
            print("Invalid URL!"); return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
                return
            }
            
            do {
                let applications = try! JSONDecoder().decode([Application].self, from: data!)
                completion(.success(applications))
            } catch let jsonError {
                completion(.failure(jsonError.localizedDescription as! Error))
            }
        }.resume()
    }
    
    func getAppDetails(appId: String, completion: @escaping (Result<[Application], Error>) -> Void) {
        guard let url = URL(string: "https://appsbymatthew-api-v5omtve52a-uc.a.run.app/api/applications?applicationId=" + appId) else {
            print("Invalid URL!"); return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
                return
            }
            
            do {
                let applications = try! JSONDecoder().decode([Application].self, from: data!)
                completion(.success(applications))
            } catch let jsonError {
                completion(.failure(jsonError.localizedDescription as! Error))
            }
        }.resume()
    }
}
