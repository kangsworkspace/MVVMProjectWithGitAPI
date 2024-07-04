//
//  TableView.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/4/24.
//

import UIKit

import Then
import SnapKit

final class TableView: UIView {
    // MARK: - Layouts
    // 백그라운드 뷰
    private let backgroundView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
    }
    
    // 테이블 뷰
    private(set) var tableView = UITableView().then {
        $0.rowHeight = 70
        $0.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
    }
    
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    // MARK: - Functions
    private func setUI() {
        backgroundView.addSubview(tableView)
        self.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

