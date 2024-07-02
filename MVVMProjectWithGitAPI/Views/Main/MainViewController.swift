//
//  ViewController.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import UIKit

import SnapKit
import Then

final class MainViewController: UIViewController {
    // MARK: - Field
    private let viewModel = MainViewModel()
    
    // MARK: - Layouts
    private lazy var searchView = SearchView().then {
        $0.textField.delegate = self
//        $0.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
//        $0.clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
//        $0.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
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
