//
//  MainViewModel.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import UIKit

import RxSwift
import RxRelay

final class MainViewModel: ViewModelType {
    // MARK: - Field
    private let networkProvider = NetworkProvider.shared
    private let disposeBag = DisposeBag()
    private let searchKeyword = BehaviorRelay<String>(value: "")
    private let userInfos = BehaviorRelay<[UserInfo]>(value: [])
    
    struct Input {
        let search: Observable<String>
        let searchTrigger: Observable<Int>
        let movePageTrigger: Observable<Int>
    }
    
    struct Output {
        let search: Observable<String>
        let userInfos: Observable<[UserInfo]>
        let userSelected: Observable<String>
    }
    
    // MARK: - Life Cycles
    init() {}
    
    // MARK: - Functions
    func transform(input: Input) -> Output {
        input.search
            .subscribe {[weak self] keyword in
                self?.searchKeyword.accept(keyword)
            }.disposed(by: disposeBag)
        
        input.searchTrigger
            .flatMapLatest({[weak self] page -> Single<UserInfoList> in
                guard let self = self else { return Single.never() }
                let keyword = self.searchKeyword.value
                guard !keyword.isEmpty else { return Single.never() }
                
                if page == 1 {
                    return self.networkProvider.fetchUserData(userID: keyword, page: page)
                } else {
                    return self.networkProvider.fetchUserData(userID: keyword, page: page)
                        .map { userInfoList in
                            let currentInfos = self.userInfos.value
                            return UserInfoList(userInfo: currentInfos + userInfoList.userInfo)
                        }
                }
            })
            .subscribe(onNext: { [weak self] userInfoList in
                self?.userInfos.accept(userInfoList.userInfo)
            }).disposed(by: disposeBag)
        
        
        let selectedURL = input.movePageTrigger
            .map {[weak self] index in
                guard let self = self else { return "" }
                return self.userInfos.value[index].url
            }
        
        return Output(search: searchKeyword.asObservable(), userInfos: userInfos.asObservable(), userSelected: selectedURL)
    }
}
