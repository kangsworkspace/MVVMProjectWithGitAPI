//
//  Extensions.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import Foundation

extension Bundle {
    var cliendID: String? {
        return infoDictionary?["CLIENT_ID"] as? String
    }
    
    var clientSecrets: String? {
        return infoDictionary?["CLIENT_SECRETS"] as? String
    }
    
    var loginRedirectURL: String? {
        return infoDictionary?["LOGINREDIRECT_URL"] as? String
    }
}
