//
//  ListPostViewModel.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import Foundation
import RxCocoa
import RxSwift
import BrigewellSdk


protocol ListPostViewModel {
    var input: ListPostInput { get }
    var output: ListPostOutput { get }
}

protocol ListPostInput {
    var onGetAllPost: AnyObserver<Void> { get }
}

protocol ListPostOutput {
    var onStartGetAllPost: Driver<[PostModel]> { get }
}
