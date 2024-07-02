//
//  UserInfoSearchType.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import Foundation

enum UserInfoSearchType {
    /// 검색 버튼 통해 유저 정보를 가져오는 경우
    case searching
    /// 페이징 처리를 통해 추가 정보를 가져오는 경우
    case paging
}
