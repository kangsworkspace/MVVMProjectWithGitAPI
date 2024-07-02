//
//  Network+Task.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import Foundation

import Moya

extension Network {
    func getTask() -> Task {
        // API 키 값 가져오기
        guard let clientID = Bundle.main.cliendID else {
            print("cliendID를 로드하지 못했습니다.")
            return .requestPlain
        }
        
        switch self {
        case .login:
            let scope = "user"
            
            let parameters: [String: Any] = [
                "client_id": clientID,
                "scope": scope
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
