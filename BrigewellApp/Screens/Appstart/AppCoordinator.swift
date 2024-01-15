//
//  AppCoordinator.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import Foundation
import BrigewellSdk
import RxSwift
import RxCocoa

final class AppCoordinator: BaseCoordinator<Void, RootDependency> {
    private let window: UIWindow

    var listPostCoordinator: ListPostCoordinator?

    init(window: UIWindow, dependency: RootDependency) {
        self.window = window
        super.init(dependency: dependency)
        observer()
    }

    private func observer() {

    }

    override func start() -> Driver<Void> {
        showPostsScreen()
        return Driver.never()
    }

    func showPostsScreen() {
        let listPostDependency = ListPostDependency(parent: dependency)
        listPostCoordinator = ListPostCoordinator(window: window, dependency: listPostDependency)
        listPostCoordinator?
            .start()
            .drive(onNext: { [weak self](deviceState) in
                self?.listPostCoordinator = nil

            })
            .disposed(by: disposeBag)
    }
}
