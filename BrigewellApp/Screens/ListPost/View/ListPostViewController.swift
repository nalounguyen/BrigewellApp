//
//  ListPostViewController.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import UIKit
import RxSwift
import BrigewellSdk

class ListPostViewController: BaseViewController<ListPostViewModel> {
    @IBOutlet weak var tableView: UITableView!
    private var listPosts: [PostModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.identifier)
        viewModel.input.onGetAllPost
            .onNext(())
    }

    override func bindingData() {
        viewModel.output.onStartGetAllPost
            .drive (onNext: { [weak self] posts in
                self?.listPosts = posts
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension ListPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        cell.configCell(listPosts[indexPath.row])

        return cell
    }
}
