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

