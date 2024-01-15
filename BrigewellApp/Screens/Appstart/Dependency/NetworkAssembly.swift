//
//  NetworkAssembly.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import Foundation
import Swinject
import BrigewellSdk

final class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container
            .register(NetworkClient.self) { resolver -> NetworkClient in
                guard let networkClient = NetworkClientImplementation(endPoint: "https://jsonplaceholder.typicode.com/") else {
                    fatalError("Initialize NetworkClient failure")
                }
                return networkClient
            }
            .inObjectScope(.container)
    }
}
