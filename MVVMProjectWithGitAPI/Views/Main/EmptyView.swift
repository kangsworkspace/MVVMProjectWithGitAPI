//
//  EmptyView.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/4/24.
//

import UIKit

import Then
import SnapKit

final class EmptyView: UIView {
    // MARK: - Layouts
    // 백그라운드 뷰
    private let backgroundView = UIView().then {
        $0.backgroundColor = .white
    }
    
    // 빈 화면 안내 레이블
    private let emptyLabel = UILabel().then {
        $0.text = "검색어에 해당하는 유저가 없어요"
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .gray
        $0.textAlignment = .center
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    // MARK: - Functions
    private func setUI() {
        backgroundView.addSubview(emptyLabel)
        self.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
            make.height.equalTo(40)
        }

        emptyLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
