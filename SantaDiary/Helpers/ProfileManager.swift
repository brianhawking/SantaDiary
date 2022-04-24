//
//  ProfileManager.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/25/21.
//

import Foundation
import UIKit

struct ProfileManager {
    
    static let shared = ProfileManager()
    
    // return path to root profile folder
    private func profileRootURL(name: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0]
            .appendingPathComponent("Users")
            .appendingPathComponent(name)
    }
    
    // return path to profile.json
    private func profileURL(name: String) -> URL {
        return profileRootURL(name: name)
            .appendingPathComponent("profile")
            .appendingPathExtension("json")
    }
    
    func isCustomImage(name: String) -> Bool {
        
        let profile = getProfile(name: name)
        return profile.customImage
    }
    
    // return path to users folder
    private func getUsersURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0]
            .appendingPathComponent("Users")
    }
    
    // return path to profile image
    func profileImageURL(name: String) -> URL {
        return profileRootURL(name: name)
            .appendingPathComponent("profilePic")
            .appendingPathExtension("png")
    }
    
    // checks if the user exists.
    func userExists(name: String) -> Bool {
        // check if a folder exists in Users
        
        // path to user's profile
        let path = profileRootURL(name: name)
        
        // check if there's a folder for user
        if FileManager.default.fileExists(atPath: path.path) {
            return true
        }
        else {
            print("\(name) does not exist.")
            return false
        }
    }
    
    func updateProgress(user: String) {
        
        let profile = getProfile(name: user)
        var newProfile = profile
        
        let niceListProgress = DiaryManager.shared.countQuestionsAnswered(for: profile.name)
        
        print("DEBUG: \(niceListProgress)")
        print("DEBUG: \(profile.smiles) \(niceListProgress.smile)")
        
        if profile.kindness < (niceListProgress.kindness / 4) {
            newProfile.kindness += 1
            
            // send letter from elf
            sendLetterNotification(user: user, from: "Elf")
        }
        if profile.smiles < (niceListProgress.smile / 4) {
            newProfile.smiles += 1
            
            // send letter from elf
            sendLetterNotification(user: user, from: "Elf")
        }
        if profile.learning < (niceListProgress.learning / 4) {
            newProfile.learning += 1
            
            // send letter from elf
            sendLetterNotification(user: user, from: "Elf")
        }
        
//        print("DEBUG: \(newProfile)")
        
        if createProfile(profile: newProfile, editingType: .edit) {
            print("DEBUG: update progress successful")
        }
    }
    
    func cancelNotification(user: String, from: String) {
        
        let profile = getProfile(name: user)
        var newProfile = profile
        
        if from == "Elf" {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [newProfile.notificationForElf])
            newProfile.notificationForElf = ""
        }
        else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [newProfile.notificationForSanta])
            newProfile.notificationForSanta = ""
        }
        
        if createProfile(profile: newProfile, editingType: .edit) {
            print("DEBUG: notification removed from \(user)")
        }
    }
    
    private func saveNotificationIdentifier(user: String, from: String, identifier: String) {
        
        let profile = getProfile(name: user)
        var newProfile = profile
        
        if from == "Elf" {
            newProfile.notificationForElf = identifier
        }
        else {
            newProfile.notificationForSanta = identifier
        }
        
        if createProfile(profile: newProfile, editingType: .edit) {
            print("DEBUG: \(identifier) saved to \(user)")
        }
        
    }
    
    func sendLetterNotification(user: String, from: String) {
        let content = UNMutableNotificationContent()
        
        
        if from == "Elf" {
            content.title = "Diary task completed!"
            content.subtitle = "\(user) is waiting for a letter from a Santa Elf."
        }
        else {
            content.title = "Santa letter sent!"
            content.subtitle = "\(user) is waiting for a letter from Santa."
        }
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

        // choose a random identifier
        let ID = UUID().uuidString
        let request = UNNotificationRequest(identifier: ID, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("DEBUG: issue sending notification")
            }
            else {
                print("DEBUG: notificaiton sent: \(ID)")
                saveNotificationIdentifier(user: user, from: from, identifier: ID)
            }
        }
    }
    
    
    func editProfile(from oldProfile: Profile, to newProfile: Profile) -> Bool {
        
        let old = profileRootURL(name: oldProfile.name)
        
        if userExists(name: newProfile.name) && oldProfile.name != newProfile.name {
            print("DEBUG: this profile already exists.")
            return false
        }
        
        let new = profileRootURL(name: newProfile.name)
        
        do{
            try FileManager.default.moveItem(atPath: old.path, toPath: new.path)
            
            let encoder = JSONEncoder()
           
            // add this to print json object better
            encoder.outputFormatting = .prettyPrinted
            
            do {
                
                let jsonData = try encoder.encode(newProfile)
                
                // json data is good
                if String(data: jsonData, encoding: .utf8) != nil {
                
                    // create the user's folder
                    do {
                        try jsonData.write(to: profileURL(name: newProfile.name))
                        
                        // change the name in all the letters
                        LetterManager.shared.editNameInLetters(oldName: oldProfile.name, newName: newProfile.name)
                        
                    }
                    catch {
                        print("error with editing file directory. \(error.localizedDescription)")
                    }
                    
                }
            }
            catch {
                print(error)
                return false
            }
            
            
        } catch   {
            print("error")
        }
        
        return true
    }
    
    func deleteProfile(profile: Profile) -> Bool {
        let user = profile.name
        if userExists(name: user) {
            // delete
            do {
                try FileManager.default.removeItem(at: profileRootURL(name: user))
                
            }
            catch {
                print("DEBUG: \(user) can not be deleted")
                return false
            }
        }
        else {
            print("DEBUG: \(user) does not exist.")
        }
        return true
    }
    
    // create new profile
    func createProfile(profile: Profile, editingType: ProfileEditType) -> Bool {
        
        let encoder = JSONEncoder()
       
        // add this to print json object better
        encoder.outputFormatting = .prettyPrinted
        
        do {
            
            let jsonData = try encoder.encode(profile)
            
            // json data is good
            if String(data: jsonData, encoding: .utf8) != nil {
            
                // check if the user has a profile
                if userExists(name: profile.name) && editingType == .create {
                    print("\(profile.name) already exists.")
                    return false
                }
                
                // create the user's folder
                do {
                    try FileManager.default.createDirectory(at: profileRootURL(name: profile.name), withIntermediateDirectories: true, attributes: nil)
                    print("Profile for \(profile.name) has been created.")
                    print(profileRootURL(name: profile.name))
                        
                    try jsonData.write(to: profileURL(name: profile.name))
                    
                }
                catch {
                    print("error with creating file directory. \(error.localizedDescription)")
                }
                
            }
        }
        catch {
            print(error)
            return false
        }
            
        return true
    }
    
    // save profile image
    func saveProfileImage(profile: Profile, image: UIImage) {
        
        let image = image
        
        var data = image.jpegData(compressionQuality: 1)! as NSData

        if profile.customImage == false {
            // premade image
            data = image.pngData()! as NSData
        }
        
        let path = profileImageURL(name: profile.name)
        if(data.write(toFile: path.path, atomically: true)) {
            print("Image successfully saved")
        } else {
            print("image not saaved")
        }
    }
    
    // update profile stuff here
    
    private func createUsersFolder() {
        
        if FileManager.default.fileExists(atPath: getUsersURL().path) {
            return
        }
        else {
            do {
                try FileManager.default.createDirectory(at: getUsersURL(), withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                print("DEBUG 1: \(error.localizedDescription)")
            }
            
        }
    }
   
    // get individual profile
    func getProfile(name: String) -> Profile {
        
        // create empty profile
        var profile = Profile(userID: 0, name: "", image: "", birthday: Date(), customImage: true)
        
        // get path to user profile.json
        let path = profileURL(name: name)
        
        do {
            // get data, decode it onto Profile
            let data = try Data(contentsOf: path)
            profile = try JSONDecoder().decode(Profile.self, from: data)
            
        }
        catch {
            print(error)
        }
        
        return profile
        
    }
    
    // get profiles
    func getProfiles() -> [Profile] {
        
        createUsersFolder()
        
        // create emtpy list
        var profiles: [Profile] = []
        
        // get path to users
        var path = getUsersURL()
        print(path)
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            // loop through users folder
            for user in directoryContents {
                
                print("DEBUG adding user: \(user)\n")
                path = profileURL(name: user.lastPathComponent)
                
                do {
                    let data = try Data(contentsOf: path)
                    let jsonResult = try JSONDecoder().decode(Profile.self, from: data)
                    profiles.append(jsonResult)
                }
            }
            
        }
        catch {
            print("DEBUG: \(error)")
        }
        
        // reorder by age
        profiles.sort { $0.birthday > $1.birthday}
        
        
        return profiles
    }
 
}
