//
//  NetworkProvider.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import UIKit

import Moya
import RxMoya
import RxSwift

final class NetworkProvider {
    // MARK: - Field
    static let shared = NetworkProvider()
    private let provider = MoyaProvider<Network>()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycels
    private init() {}
    
    // MARK: - Functions
    /// 깃 로그인
    func login() {
        provider.rx.request(.login)
            .do(onSuccess: { response in
                if let url = response.request?.url {
                    // 웹 브라우저에서 URL 열기
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }, onError: { error in
                print("GitHub 로그인을 시작하지 못했습니다:", error)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
