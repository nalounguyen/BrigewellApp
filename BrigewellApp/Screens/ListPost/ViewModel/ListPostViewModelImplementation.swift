//
//  ListPostViewModelImplementation.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import Foundation
import RxSwift
import RxCocoa
import BrigewellSdk

final class ListPostViewModelImplementation {
    private let getPostsUseCase: GetPostsUseCase
    private let getCommentsUseCase: GetCommentsUseCase

    private let onGetAllPostSubject = PublishSubject<Void>()
    private let onStartGetAllPostSubject = PublishSubject<[PostModel]>()
    private var listPosts: [PostModel] = [PostModel]()
    
    
    private var disposeBag = DisposeBag()

    init(getPostsUseCase: GetPostsUseCase,
         getCommentsUseCase: GetCommentsUseCase) {
        self.getPostsUseCase = getPostsUseCase
        self.getCommentsUseCase = getCommentsUseCase
        binding()
    }

    private func binding() {
        onGetAllPostSubject
            .subscribe { [weak self] _ in
                self?.getListPost()
            }
            .disposed(by: disposeBag)
    }
    
    func getListPost() {
        self.getPostsUseCase
            .execute()
            .subscribe (onNext: { [weak self] posts in
                self?.listPosts = posts
                let ids = posts.map { $0.id }
                self?.getListComments(ids: ids)
                self?.onStartGetAllPostSubject.onNext(posts)
            })
            .disposed(by: disposeBag)
    }
    
    func getListComments(ids: [Int]) {
        DispatchQueue.global().async {
            self.getCommentsUseCase
                .execute(listPostId: ids)
                .subscribe (onNext: { [weak self] comments in
                    guard let self = self else { return }
                    for post in self.listPosts.enumerated() {
                        var tempPost = post.element
                        tempPost.comments = comments.filter { comment in
                            return tempPost.id == comment.postId
                        }
                        
                        listPosts[post.offset] = tempPost
                    }
                    self.onStartGetAllPostSubject.onNext(self.listPosts)
                })
                .disposed(by: self.disposeBag)
        }
        
        
        
    }

}


// MARK: ListPostStreamFlow
extension ListPostViewModelImplementation: ListPostViewModel {
    var input: ListPostInput {
        return self
    }

    var output: ListPostOutput {
        return self
    }
}

// MARK: ListPostInput
extension ListPostViewModelImplementation: ListPostInput {
    var onGetAllPost: AnyObserver<Void> {
        return onGetAllPostSubject
            .asObserver()
    }
}

// MARK: ListPostOutput
extension ListPostViewModelImplementation: ListPostOutput {
    var onStartGetAllPost: Driver<[PostModel]> {
        return onStartGetAllPostSubject
            .asDriver(onErrorDriveWith: .never())
    }
}


extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
