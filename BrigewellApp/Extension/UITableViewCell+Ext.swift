//
//  UITableViewCell+Ext.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }

    /// Returns the UINib with nibName matching the cell's identifier.
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
