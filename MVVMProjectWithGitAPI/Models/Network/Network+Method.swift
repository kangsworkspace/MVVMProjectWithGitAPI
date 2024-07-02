//
//  Network+Method.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import Foundation

import Moya

extension Network {
    func getMethod() -> Moya.Method {
        switch self {
        case .login:
            return .get
        }
    }
}
