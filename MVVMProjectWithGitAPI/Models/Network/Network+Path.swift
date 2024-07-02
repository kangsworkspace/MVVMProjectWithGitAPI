//
//  Network+Path.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import Foundation

extension Network {
  func getPath() -> String {
    switch self {
    case .login:
        return "/login/oauth/authorize"
    case .getToken:
        return"/login/oauth/access_token"
    }
  }
}
