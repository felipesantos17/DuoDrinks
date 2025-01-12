//
//  SearchCategoryCollectionViewCell.swift
//  DuoDrinks
//
//  Created by Felipe Santos on 01/12/24.
//

import UIKit

final class SearchCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleCustomLabel: UILabel?

    static let identifier: String = "SearchCategoryCollectionViewCell"
    
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
