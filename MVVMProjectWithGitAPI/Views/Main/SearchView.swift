//
//  SearchView.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/3/24.
//

import UIKit

import SnapKit
import Then

final class SearchView: UIView {
    // MARK: - Layouts
    // 백그라운드 뷰
    private let backgroundView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .lightGray.withAlphaComponent(0.2)
    }
    
    // 스택뷰
    private let searchStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // search 텍스트 필드
    private(set) var textField = UITextField().then {
        $0.backgroundColor = .clear
        $0.placeholder = "유저 검색"
        $0.autocapitalizationType = .none
        $0.clearsOnBeginEditing = false
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.returnKeyType = .search
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // clear 버튼
    private(set) var clearButton = UIButton().then {
        $0.isHidden = true
        $0.setImage(UIImage(systemName: "x.circle")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // search 버튼
    private(set) var searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    // MARK: - Functions
    private func setUI() {
        searchStackView.addArrangedSubview(textField)
        searchStackView.addArrangedSubview(clearButton)
        searchStackView.addArrangedSubview(searchButton)
        backgroundView.addSubview(searchStackView)
        self.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
            make.height.equalTo(36)
        }
        
        searchStackView.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundView.snp.centerY)
            
            make.leading.equalTo(backgroundView.snp.leading).offset(15)
            make.trailing.equalTo(backgroundView.snp.trailing).offset(-6)
            
            make.height.equalTo(30)
        }
        
        clearButton.snp.makeConstraints { make in
            make.trailing.equalTo(searchButton.snp.leading)
            
            make.width.equalTo(30)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalTo(searchStackView.snp.trailing)
            
            make.width.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
