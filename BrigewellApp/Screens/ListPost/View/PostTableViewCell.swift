//
//  PostTableViewCell.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import UIKit
import BrigewellSdk

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(_ post: PostModel) {
        titleLbl.text = post.title
        bodyLbl.text = post.body
        let totalComments = post.comments?.count ?? 0
        commentLbl.text = "\(totalComments) comments"
    }
    
}
