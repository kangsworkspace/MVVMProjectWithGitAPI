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
import Kingfisher
import Then

final class MainViewController: UIViewController {
    // MARK: - Field
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    private let searchTrigger = BehaviorSubject<Int>(value: 1)
    
    // MARK: - Layouts
    private lazy var searchView = SearchView().then {
        $0.clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }
    
    private var tableView = TableView()
    
    private var emptyView = EmptyView().then {
        $0.isHidden = true
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
        view.addSubview(tableView)
        view.addSubview(emptyView)
        
        searchView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
            make.top.equalTo(searchView.snp.bottom).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(40)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bindViewModel() {
        let keyword = searchView.textField.rx.text.orEmpty
            .asObservable()
        
        let input = MainViewModel.Input(search: keyword, searchTrigger: searchTrigger)
        let output = viewModel.transform(input: input)
        
        output.search
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: {[weak self] keyword in
                self?.setClearButton(keyword: keyword)
            }).disposed(by: disposeBag)
        
        output.userInfos
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.tableView.rx.items(cellIdentifier: TableViewCell.id, cellType: TableViewCell.self)) { index, userInfo, cell in
                cell.selectionStyle = .none
                cell.setConfig(name: userInfo.login, urlString: userInfo.url)
                cell.setImage(with: userInfo.avatarURL)
            }.disposed(by: disposeBag)
        
        output.userInfos
            .asDriver(onErrorJustReturn: [])
            .filter({[weak self] _ in
                guard let keyword = self?.searchView.textField.text else { return false}
                return !keyword.isEmpty
            })
            .drive(onNext: { [weak self] userInfos in
                self?.checkEmpty(userInfo: userInfos)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindView() {
        // 검색 버튼(돋보기)을 눌렀을 때
        searchView.searchButton.rx.tap.bind {[weak self] in
            self?.searchTrigger.onNext(1)
            self?.view.endEditing(true)
        }.disposed(by: disposeBag)
        
        // 키보드의 검색 버튼을 눌렀을 때
        searchView.textField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] in
                self?.searchTrigger.onNext(1)
            }).disposed(by: disposeBag)
                
        // 페이징 처리
        tableView.tableView.rx.prefetchRows
            .bind {[weak self] indexPath in
                guard let self = self else { return }
                guard let lastIndexPath = indexPath.last else { return }
                let numberOfRows = self.tableView.tableView.numberOfRows(inSection: lastIndexPath.section)
                guard let currentPage = try? self.searchTrigger.value() else { return }
                
                if lastIndexPath.row > numberOfRows - 2 {
                    self.searchTrigger.onNext(currentPage + 1)
                }
            }.disposed(by: disposeBag)
        
        // 테이블 뷰 눌렀을 때 동작
        tableView.tableView.rx.itemSelected
            .subscribe(onNext: {[weak self] indexPath in
                guard let self = self else { return }
                if self.searchView.textField.isFirstResponder {
                    self.view.endEditing(true)
                } else {
                    print("페이지 이동 로직")
                }
            }).disposed(by: disposeBag)
    }

    /// clearButton 동작 로직(텍스트 변화 시)
    private func setClearButton(keyword: String) {
        if keyword.isEmpty {
            searchView.clearButton.isHidden = true
        } else {
            searchView.clearButton.isHidden = false
        }
    }
    
    /// clearButton 동작 로직(버튼이 눌렸을 때)
    @objc private func clearButtonTapped() {
        searchView.textField.text = ""
        searchView.clearButton.isHidden = true
    }
    
    /// 데이터가 없을 때 EmptyView 보여주기
    private func checkEmpty(userInfo: [UserInfo]) {
        if userInfo.isEmpty == true {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
    }
    
    /// 다른 화면을 눌렀을 때 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
