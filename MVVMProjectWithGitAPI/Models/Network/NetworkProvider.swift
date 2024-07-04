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
    private var accessToken = ""
    
    // MARK: - Life Cycels
    private init() {
        login()
    }
    
    // MARK: - Functions
    /// 깃 로그인
    private func login() {
        provider.rx.request(.login)
            .subscribe(onSuccess: { response in
                if let url = response.request?.url {
                    // 웹 브라우저에서 URL 열기
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }, onFailure: { error in
                print("GitHub 로그인을 시작하지 못했습니다:", error)
            }).disposed(by: disposeBag)
    }
    
    /// AccessToken 가져오기
    /// - Parameter tempCode:(String) : 로그인을 통해 가져온 임시 코드
    func fetchAccessToken(tempCode: String) {
        provider.rx.request(.getToken(tempCode: tempCode))
            .subscribe {[weak self] response in
                do {
                    guard let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] else { return }
                    self?.accessToken = (json["access_token"] as? String)!
                } catch let error {
                    print("Error parsing response: \(error)")
                }
            }.disposed(by: disposeBag)
    }
    
    /// 유저 정보 가져오기
    /// - Parameter userID:(String) : 검색할 유저의 ID
    /// - Parameter page:(Int) : 페이징 처리를 위한 페이지 값
    /// - returns: 클로져로 종료 시점을 전달
    func fetchUserData(userID: String, page: Int?) -> Single<UserInfoList> {
        provider.rx.request(.gitUserInfo(accessToken: accessToken, userID: userID, page: page))
            .debug()
            .map { response in
                let decoder = JSONDecoder()
                let result = try decoder.decode(UserInfoList.self, from: response.data)
                return result
            }
    }
}
