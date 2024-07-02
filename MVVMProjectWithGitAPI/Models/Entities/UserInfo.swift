//
//  UserInfo.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import Foundation

struct UserInfoResults: Codable {
    /// 유저 데이터 정보
    let userInfo: [UserInfo]
    
    enum CodingKeys: String, CodingKey {
        case userInfo = "items"
    }
}

// MARK: - Item
struct UserInfo: Codable {
    let login: String
    let avatarURL: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case url = "html_url"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login = try container.decode(String.self, forKey: .login)
        self.avatarURL = try container.decode(String.self, forKey: .avatarURL)
        self.url = try container.decode(String.self, forKey: .url)
    }
}
