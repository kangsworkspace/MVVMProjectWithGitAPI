//
//  ViewController.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/2/24.
//

import UIKit

final class MainViewController: UIViewController {

    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.login()
    }
}

