//
//  DiaryManager.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/22/22.
//

import Foundation

struct DiaryManager {
    static let shared = DiaryManager()
    
    // return path to root profile folder
    private func getDiaryFolderURL(user: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0]
            .appendingPathComponent("Users")
            .appendingPathComponent(user)
            .appendingPathComponent("Diary")
    }
    
    private func getDiaryFileURL(user: String, fileName: String) -> URL {
        let path = getDiaryFolderURL(user: user)
            .appendingPathComponent(fileName)
            .appendingPathExtension("json")
        
        return path
    }
    
 
    private func createFileName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD-HH-mm-ss"
        return dateFormatter.string(from: date)
    }
    
    func createDiaryFolder(for user: String) {
        
        if FileManager.default.fileExists(atPath: getDiaryFolderURL(user: user).path) {
            return
        }
        else {
            do {
                try FileManager.default.createDirectory(at: getDiaryFolderURL(user: user), withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                print("DEBUG: \(error.localizedDescription)a")
            }
        }
    }
    
    func createDiaryEntry(entry: DiaryEntry) -> Bool {
        
        let encoder = JSONEncoder()
       
        // add this to print json object better
        encoder.outputFormatting = .prettyPrinted
        
        do {
            
            let jsonData = try encoder.encode(entry)
            
            // json data is good
            if String(data: jsonData, encoding: .utf8) != nil {
            
                // create the letters folder
                do {
                                        
                    try FileManager.default.createDirectory(at: getDiaryFolderURL(user: entry.author), withIntermediateDirectories: true, attributes: nil)
            
                    let fileName = createFileName(from: entry.date)
                    
                    try jsonData.write(to: getDiaryFileURL(user: entry.author, fileName: fileName))
                    
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
        
        ProfileManager.shared.updateProgress(user: entry.author)
        return true
        
    }
    
    func getDiaryEntries(for user: String) -> [DiaryEntry] {
        
        // just in case the folder doesn't exist
        createDiaryFolder(for: user)
        
        // create empty list of letters
        var entries: [DiaryEntry] = []
        
        // get path to letters folder
        let pathToDiaryFolder = getDiaryFolderURL(user: user)
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: pathToDiaryFolder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            // loop through letters
            for entry in directoryContents {
                
                do {
                    let data = try Data(contentsOf: entry)
                    let jsonResult = try JSONDecoder().decode(DiaryEntry.self, from: data)
                    
                    entries.append(jsonResult)
    
                }
                
            }
        }
        catch {
            print("DEBUG: \(error)")
        }
        
        entries.sort {$0.date > $1.date}
        
        return entries
        
    }
    
    func countQuestionsAnswered(for user: String) -> NiceListProgress {
        
        let diaryEntries = getDiaryEntries(for: user)
        
        var niceListProgress = NiceListProgress(kindness: 0, learning: 0, smile: 0)
        
        if diaryEntries.count == 0 {
            return niceListProgress
        }
        
        for entry in diaryEntries {
            switch entry.prompts[1].question {
            case QuestionType.kindness.rawValue:
                niceListProgress.kindness += 1
            case QuestionType.learning.rawValue:
                niceListProgress.learning += 1
            default:
                niceListProgress.smile += 1
            }
        }
        
        return niceListProgress
    }
}
