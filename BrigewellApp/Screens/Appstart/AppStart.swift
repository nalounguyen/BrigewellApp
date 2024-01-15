//
//  AppStart.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import Foundation
import RxSwift
import UIKit

final class AppStart {
    let window: UIWindow
    var appCoordinator: AppCoordinator?
    var disposeBag = DisposeBag()
    var rootDependency: RootDependency

    init(window: UIWindow) {
        self.window = window
        self.rootDependency = RootDependency()
    }

    func start() {
        appCoordinator = AppCoordinator(window: window, dependency: rootDependency)
        appCoordinator?.start()
            .drive()
            .disposed(by: disposeBag)
    }
}
