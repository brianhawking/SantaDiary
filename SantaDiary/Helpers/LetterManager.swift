//
//  LetterManager.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/4/22.
//

import Foundation

struct LetterManager {
    
    static let shared = LetterManager()
 
    // return path to root profile folder
    private func getLettersFolderURL(user: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0]
            .appendingPathComponent("Users")
            .appendingPathComponent(user)
            .appendingPathComponent("Letters")
    }
    
    private func getLetterURL(user: String, fileName: String) -> URL {
        let path = getLettersFolderURL(user: user)
            .appendingPathComponent(fileName)
            .appendingPathExtension("json")
        
        return path
    }
    
    private func getLetterURL(from letter: Letter) -> URL {
        
        var path: URL?
        
        if letter.authorType == "User" {
            path = getLettersFolderURL(user: letter.author).appendingPathComponent(createFileName(from: letter.date))
                .appendingPathExtension("json")
        }
        else {
            path = getLettersFolderURL(user: letter.recipient).appendingPathComponent(createFileName(from: letter.date))
                .appendingPathExtension("json")
        }
        
        return path!
    }
    
    func editNameInLetters(oldName: String, newName: String) {
        
        // get path to letters folder
        let pathToLettersFolder = getLettersFolderURL(user: newName)
        print("DEBUG: \(pathToLettersFolder)")
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: pathToLettersFolder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            // loop through letters
            for letter in directoryContents {
                
                print("DEBUG: \(letter)")
                
                do {
                    let data = try Data(contentsOf: letter)
                    let result = try JSONDecoder().decode(Letter.self, from: data)
                    
                    // add code here to filter
                    switch result.authorType {
                        
                    case "User":
                        result.author = newName
                    default:
                        result.recipient = newName
                    }
                    
                    do {
                        let encoder = JSONEncoder()
                        encoder.outputFormatting = .prettyPrinted
                        let jsonResult = try encoder.encode(result)
                        try jsonResult.write(to: letter)
                    }
                    
                }
                
            }
        }
        catch {
            print("DEBUG: FROM LETTER MANAGRER: \(error)")
        }
        
    }
    
    private func createFileName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD-HH-mm-ss"
        return dateFormatter.string(from: date)
    }
    
   
    
    func createLetter(letter: Letter) -> Bool {
        
        let encoder = JSONEncoder()
       
        // add this to print json object better
        encoder.outputFormatting = .prettyPrinted
        
        do {
            
            let jsonData = try encoder.encode(letter)
            
            // json data is good
            if String(data: jsonData, encoding: .utf8) != nil {
            
                var user = ""
                
                // create the letters folder
                do {
                    
                    switch letter.authorType {
                    case "User":
                        user = letter.author
                    default:
                        user = letter.recipient
                    }
                    
                    try FileManager.default.createDirectory(at: getLettersFolderURL(user: user), withIntermediateDirectories: true, attributes: nil)
                                   
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY-MM-DD-HH-mm-ss"
                    let fileName = dateFormatter.string(from: letter.date)
                    
                    try jsonData.write(to: getLetterURL(user: user, fileName: fileName))
                    
                }
                catch {
                    print("Debug: error with creating file directory. \(error.localizedDescription)")
                    return false
                }
                
            }
        }
        catch {
            print("Debug: \(error)")
            return false
        }
            
        return true
        
    }
    
    func createLettersFolder(for user: String) {
        
        if FileManager.default.fileExists(atPath: getLettersFolderURL(user: user).path) {
            return
        }
        else {
            do {
                try FileManager.default.createDirectory(at: getLettersFolderURL(user: user), withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                print("DEBUG: \(error.localizedDescription)a")
            }
        }
    }
    
    func getLetters(for user: String, type: LetterType) -> [Letter] {
        
        // just in case the folder doesn't exist
        createLettersFolder(for: user)
        
        // create empty list of letters
        var letters: [Letter] = []
        
        // get path to letters folder
        let pathToLettersFolder = getLettersFolderURL(user: user)
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: pathToLettersFolder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            // loop through letters
            for letter in directoryContents {
                
                do {
                    let data = try Data(contentsOf: letter)
                    let jsonResult = try JSONDecoder().decode(Letter.self, from: data)
                    
                    // add code here to filter
                    switch type {
                        
                    case .sent:
                        if jsonResult.authorType == "User" {
                            letters.append(jsonResult)
                        }
                    case .received:
                        if jsonResult.authorType != "User" {
                            letters.append(jsonResult)
                        }
                    case .showAll:
                        letters.append(jsonResult)
                    case .unread:
                        if jsonResult.unread == true {
                            letters.append(jsonResult)
                        }
                    }

                    
                }
                
            }
        }
        catch {
            print("DEBUG: \(error)")
        }
        
        letters.sort {$0.date > $1.date}
        
        return letters
        
    }
    
    func updateLetterStatus(for letter: Letter) {
        
        // change unread to false
        letter.unread = false
        
        // get path to letter
        let path = getLetterURL(from: letter)
        
        
        // add this to print json object better
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(letter)
            try jsonData.write(to: path)
        }
        catch {
            print(path)
            print("DEBUG: \(error.localizedDescription)")
        }
        
    }
    
}
