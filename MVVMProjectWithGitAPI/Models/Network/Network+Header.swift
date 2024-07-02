//
//  Network+Header.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import Foundation

extension Network {
    func getHeader() -> [String : String]? {
        switch self {
        case .login:
            return nil
        case .getToken:
            return ["Accept": "application/json"]
        case let .gitUserInfo(accessToken,_,_):
            return [
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(accessToken)",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
        }
    }
}
