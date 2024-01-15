//
//  ListPostAssemply.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import Foundation
import Swinject
import BrigewellSdk

final class ListPostAssemply: Assembly {
    func assemble(container: Container) {
        container
            .register(GetPostsUseCase.self) { resolver -> GetPostsUseCase in
                guard let repository = resolver.resolve(PostRepository.self) else {
                    fatalError("can't resolve GetPostsUseCase")
                }
                return GetPostsUseCaseImplementation(postRepository: repository)
            }
            .inObjectScope(.container)
        
        container
            .register(GetCommentsUseCase.self) { resolver -> GetCommentsUseCase in
                guard let repository = resolver.resolve(PostRepository.self) else {
                    fatalError("can't resolve GetPostsUseCase")
                }
                return GetCommentsUseCaseImplementation(postRepository: repository)
            }
            .inObjectScope(.container)

        container
            .register(PostRepository.self) { resolver -> PostRepository in
                guard let networking = resolver.resolve(NetworkClient.self) else {
                    fatalError("can't resolve Networking")
                }
                return PostRepositoryImplementation(networking: networking)
            }
            .inObjectScope(.container)

        container.register(ListPostViewModel.self) { resolver -> ListPostViewModel in
            guard let getPostsUseCase = resolver.resolve(GetPostsUseCase.self) else {
                fatalError("can't resolve \(GetPostsUseCase.self)")
            }
            
            guard let getCommentsUseCase = resolver.resolve(GetCommentsUseCase.self) else {
                fatalError("can't resolve \(GetCommentsUseCase.self)")
            }
            
            return ListPostViewModelImplementation(getPostsUseCase: getPostsUseCase,
                                                   getCommentsUseCase: getCommentsUseCase)
        }.inObjectScope(.container)
    }
}
