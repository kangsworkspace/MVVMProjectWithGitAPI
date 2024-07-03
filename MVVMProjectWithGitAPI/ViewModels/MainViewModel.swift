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
    
    struct Input {
        let search: Observable<String>
    }
    
    struct Output {
        let search: Observable<String>
    }
    
    // MARK: - Life Cycles
    init() {}
    
    // MARK: - Functions
    func transform(input: Input) -> Output {
        input.search
            .subscribe {[weak self] keyword in
                self?.searchKeyword.accept(keyword)
            }.disposed(by: disposeBag)
        
        return Output(search: searchKeyword.asObservable())
    }
}
