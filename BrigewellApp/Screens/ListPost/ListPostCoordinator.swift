//
//  ListPostCoordinator.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import UIKit
import RxCocoa
import Swinject
import BrigewellSdk

final class ListPostCoordinator: BaseCoordinator<Void, ListPostDependency> {

    private let window: UIWindow
    private let viewModel: ListPostViewModel

    init(window: UIWindow, dependency: ListPostDependency) {
        self.window = window
        viewModel = dependency.resolve(ListPostViewModel.self)
        super.init(dependency: dependency)
    }

    override func start() -> Driver<Void> {
        let controller = ListPostViewController(viewModel: viewModel)
        window.rootViewController = controller
        window.makeKeyAndVisible()

        return Driver.never()
    }

    override func viewModelBinding() {
        super.viewModelBinding()
    }
}
