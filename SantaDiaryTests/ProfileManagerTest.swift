//
//  ProfileManagerTest.swift
//  SantaDiaryTests
//
//  Created by Brian Veitch on 1/15/22.
//

import XCTest
@testable import SantaDiary

class ProfileManagerTest: XCTestCase {

    let profile = Profile(userID: 0, name: "abcdefghijk", image: "profilePic.png", birthday: Date(), customImage: true)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_createProfile() {
        XCTAssertTrue(ProfileManager.shared.createProfile(profile: profile, editingType: .create))
    }
    
//    func test_userExists() {
//        XCTAssertTrue(ProfileManager.shared.userExists(name: "abcdefghijk"))
//    }
//    
//    func test_userDoesNotExist() {
//        XCTAssertFalse(ProfileManager.shared.userExists(name: "somefakename"))
//    }
    
    func test_delteProfile() {
        XCTAssertTrue(ProfileManager.shared.deleteProfile(profile: profile))
    }

}
