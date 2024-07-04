//
//  TableViewCell.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/4/24.
//

import UIKit

import Then
import SnapKit
import Kingfisher

final class TableViewCell: UITableViewCell {
    // MARK: - Field
    static let id = "TableViewCell"
    
    // MARK: - Layouts
    /// 유저 아바타 이미지 뷰
    private lazy var userImageView = UIImageView().then {
        $0.backgroundColor = .clear
    }
    
    /// 유저 이름
    private var nameLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    /// 유저 URL
    private var urlLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.4
    }

    // MARK: - Life Cycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setAutoLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userImageView.image = nil
        nameLabel.text = nil
        urlLabel.text = nil
    }
    
    // MARK: - Functions
    func setAutoLayout() {
        self.addSubview(userImageView)
        self.addSubview(nameLabel)
        self.addSubview(urlLabel)
        
        
        userImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            
            make.leading.equalToSuperview().offset(10)
            
            make.width.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(10)
            make.top.equalTo(userImageView.snp.top)
            make.trailing.equalToSuperview().offset(10)
            
            make.height.equalTo(25)
        }
        
        urlLabel.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(10)
            make.bottom.equalTo(userImageView.snp.bottom)
            make.trailing.equalToSuperview().offset(-10)
            
            make.height.equalTo(20)
        }
    }
    
    func setConfig(name: String, urlString: String) {
        nameLabel.text = name
        urlLabel.text = urlString
    }
    
    func setImage(with urlString: String) {
        let url = URL(string: urlString)!
        userImageView.kf.indicatorType = .activity
        userImageView.kf.setImage(with: url)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
