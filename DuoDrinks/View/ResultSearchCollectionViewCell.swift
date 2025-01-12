//
//  ResultSearchCollectionViewCell.swift
//  DuoDrinks
//
//  Created by Felipe Santos on 02/01/25.
//

import UIKit

final class ResultSearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ResultSearchCollectionViewCell"
    
    @IBOutlet weak var resultLabel: UILabel?

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func configTitleCell(_ title: String) {
        titleLabel.text = title
    }
    
    private func setupConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
