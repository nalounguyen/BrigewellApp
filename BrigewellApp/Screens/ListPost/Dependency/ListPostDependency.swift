//
//  ListPostDependency.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import Foundation
import Swinject
import BrigewellSdk

class ListPostDependency: Dependency {
    override func setup() {
        assembler.apply(assembly: ListPostAssemply())
    }
}
