//
//  Network+BaseURL.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import Foundation

extension Network {
  func getBaseURL() -> URL {
      switch self {
      case .login:
          return URL(string: "https://github.com")!
      }
  }
}
