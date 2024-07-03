//
//  ViewController.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class MainViewController: UIViewController {
    // MARK: - Field
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Layouts
    private lazy var searchView = SearchView().then {
        $0.textField.delegate = self
//        $0.clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
//        $0.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bindViewModel()
        bindView()
    }
    
    // MARK: - Functions
    private func setUI() {
        // 배경화면 색상 설정
        view.backgroundColor = .white
        
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    private func bindViewModel() {
        
    }
    
    private func bindView() {
        let keyword = searchView.textField.rx.text.orEmpty
            .asObservable()
        
        let input = MainViewModel.Input(search: keyword)
        let output = viewModel.transform(input: input)
        
        output.search
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: {[weak self] keyword in
                print(keyword)
                self?.setClearButton(keyword: keyword)
            }).disposed(by: disposeBag)
        
//        buttonView.tvButton.rx.tap.bind { [weak self] in
//            self?.textField.isHidden = false
//            self?.tvTrigger.onNext(1)
//        }.disposed(by: disposeBag)
        
    }
    
    
//    // clearButton 히든 처리 로직
//    @objc func textFieldDidChange() {
//        if searchView.textField.text == "" {
//            searchView.clearButton.isHidden = true
//        } else {
//            searchView.clearButton.isHidden = false
//        }
//    }
    
    private func setClearButton(keyword: String) {
        if keyword.isEmpty {
            searchView.clearButton.isHidden = true
        } else {
            searchView.clearButton.isHidden = false
        }
    }
}

// UITextField의 델리게이트 설정을 위한 extension
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            print("searchButton Tapped")
        }
        
        return true
    }
}
