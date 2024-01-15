//
//  RootDependency.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import Foundation
import Swinject
import BrigewellSdk

final class RootDependency: Dependency {
    override func setup() {
        let networkAssembly = NetworkAssembly()

        assembler.apply(assemblies: [networkAssembly])
    }
}
