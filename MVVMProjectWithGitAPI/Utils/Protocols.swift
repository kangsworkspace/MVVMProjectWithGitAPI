//
//  Protocols.swift
//  MVVMProjectWithGitAPI
//
//  Created by Healthy on 7/3/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
