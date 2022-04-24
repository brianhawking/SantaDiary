//
//  FeedbackManager.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/25/22.
//

import Foundation

struct FeedbackManager {
    
    static let shared = FeedbackManager()
    
    // manager functions below
    
    // MARK: - HELPERS
    
    private func getFeedbackURL(name: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0]
            .appendingPathComponent("Users")
            .appendingPathComponent(name)
            .appendingPathComponent("feedback")
            .appendingPathExtension("json")
    }
    
    // MARK: - CREATE
    
    func createFeedback(feedback: Feedback) -> Bool {
        
        let encoder = JSONEncoder()
       
        // add this to print json object better
        encoder.outputFormatting = .prettyPrinted
        
        do {
            
            let jsonData = try encoder.encode(feedback)
            
            // json data is good
            if String(data: jsonData, encoding: .utf8) != nil {
                
                
                do {
                        
                    try jsonData.write(to: getFeedbackURL(name: feedback.name))
                    
                }
                catch {
                    print("error with creating file: \(error.localizedDescription)")
                }
                
            }
        }
        catch {
            print("DEBUG: \(error)")
            return false
        }
            
        return true
    }
    
    // MARK: - READ
    
    // get individual profile
    func getFeedback(name: String) -> Feedback {
        
        // create empty feedback
        var feedback = Feedback(name: name, image: "Happy", feedback: "There was an error retreiving your feedback", goals: [])
        
        // get path to user feedback.json
        let path = getFeedbackURL(name: name)
        
        do {
            // get data, decode it onto Profile
            let data = try Data(contentsOf: path)
            feedback = try JSONDecoder().decode(Feedback.self, from: data)
            
        }
        catch {
            print(error)
        }
        
        return feedback
        
    }
    
    // MARK: - UPADTE
    
    func updateFeedback(feedback: Feedback) -> Bool {
        
        let encoder = JSONEncoder()
       
        // add this to print json object better
        encoder.outputFormatting = .prettyPrinted
        
        do {
            
            let jsonData = try encoder.encode(feedback)
            
            // json data is good
            if String(data: jsonData, encoding: .utf8) != nil {
                
                
                do {
                        
                    try jsonData.write(to: getFeedbackURL(name: feedback.name))
                    
                }
                catch {
                    print("error with creating file: \(error.localizedDescription)")
                }
                
            }
        }
        catch {
            print(error)
            return false
        }
            
        return true
    }
    
    
    // MARK: - DELETE
}
