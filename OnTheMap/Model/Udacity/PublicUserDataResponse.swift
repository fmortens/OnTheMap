//
//  PublicUserDataResponse.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 08/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

struct PublicUserDataResponse: Codable {
    let key: String?
    let affiliateProfiles: [String]?
    let enrollments: [String]?
    let tags: [String]?
    let lastName: String?
    let emailPreferences: EmailPreferences?
    let imageUrl: String?
    let memberships: [Membership]?
    let hasPassword: Bool?
    let employerSharing: Bool?
    let cohortKeys: [String]?
    let registered: Bool?
    let externalAccounts: [String]?
    let firstName: String?
    let badges: [String]?
    let nickname: String?
    let email: Email?
    let principals: [Ref]?
    let socialAccounts: [String]?
    let guardNode: Guard?
    
    enum CodingKeys: String, CodingKey {
        case key
        case affiliateProfiles = "_affiliate_profiles"
        case enrollments = "_enrollments"
        case tags
        case lastName = "last_name"
        case emailPreferences = "email_preferences"
        case imageUrl = "_image_url"
        case memberships = "_memberships"
        case hasPassword = "_has_password"
        case employerSharing = "employer_sharing"
        case cohortKeys = "_cohort_keys"
        case registered = "_registered"
        case externalAccounts = "external_accounts"
        case firstName = "first_name"
        case badges = "_badges"
        case nickname
        case email
        case principals = "_principals"
        case socialAccounts = "social_accounts"
        case guardNode = "guard"
    }
}

struct Membership: Codable {
    let current: Bool?
    let groupRef: Ref?
    let creationTime: String?
    let expirationTime: String?
    
    enum CodingKeys: String, CodingKey {
        case current
        case groupRef = "group_ref"
        case creationTime = "creation_time"
        case expirationTime = "expiration_time"
    }
}

struct EmailPreferences: Codable {
    let okUserResearch: Bool?
    let masterOk: Bool?
    let okCourse: Bool?
    
    enum CodingKeys: String, CodingKey {
        case okUserResearch = "ok_user_research"
        case masterOk = "master_ok"
        case okCourse = "ok_course"
    }
    
}

struct Guard: Codable {
    let canEdit: Bool?
    let permissions: [Permission]?
        
    enum CodingKeys: String, CodingKey {
        case canEdit = "can_edit"
        case permissions
    }
}

struct Permission: Codable {
    let derivation: [String]?
    let behavior: String?
    let principalRef: Ref?
    
    enum CodingKeys: String, CodingKey {
        case derivation
        case behavior
        case principalRef = "principal_ref"
    }
}

struct Ref: Codable {
    let ref: String?
    let key: String?
    
    enum CodingKeys: String, CodingKey {
        case ref
        case key
    }
}

struct Email: Codable {
    let verificationCodeSent: Bool?
    let verified: Bool?
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case verificationCodeSent = "_verification_code_sent"
        case verified = "_verified"
        case address
    }
}
