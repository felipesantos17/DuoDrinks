//
//  DrinkDetailView.swift
//  DuoDrinks
//
//  Created by Felipe Santos on 03/12/24.
//

import UIKit

class DrinkDetailView: UIView {
    private let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 18, weight: .bold)
    ]
    private let sizeText: CGFloat = 16
    
    lazy var drinkThumbImageView = UIImageView()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    lazy var categoryLabel = UILabel()
    lazy var alcoholicLabel = UILabel()
    lazy var glassLabel = UILabel()

    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var titleIngredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients and Measures"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var scrollMainStackView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()

    lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            categoryLabel,
            alcoholicLabel,
            glassLabel,
            instructionsLabel,
            titleIngredientsLabel
        ])
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .equalSpacing
        stack.spacing = 6
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with drink: Drink?, _ items: [String]) {
        guard let drink else {
            return
        }
        drinkThumbImageView.loadImage(from: drink.strDrinkThumb, contentMode: .scaleAspectFit)
        titleLabel.text = drink.strDrink?.uppercased()
        
        let categoryText = NSMutableAttributedString()
            .bold("Category: ", size: sizeText)
            .normal(drink.strCategory ?? "")
        
        let alcoholicText = NSMutableAttributedString()
            .bold("Alcoholic: ", size: sizeText)
            .normal(drink.strAlcoholic ?? "")
        
        let glassText = NSMutableAttributedString()
            .bold("Glass: ", size: sizeText)
            .normal(drink.strGlass ?? "")
        
        let instructionsText = NSMutableAttributedString()
            .bold("Instructions: ", size: sizeText)
            .normal(drink.strInstructions ?? "")
        
        categoryLabel.attributedText = categoryText
        alcoholicLabel.attributedText = alcoholicText
        glassLabel.attributedText = glassText
        instructionsLabel.attributedText = instructionsText
        
        configItems(items)
    }
    
    private func configItems(_ items: [String]) {
        items.forEach { item in
            let label = UILabel()
            label.font = .systemFont(ofSize: 16, weight: .regular)
            label.text = item
            mainStackView.addArrangedSubview(label)
        }
    }
    
    
    private func setup() {
        backgroundColor = .systemBackground
        
        addSubview(drinkThumbImageView)
        addSubview(titleLabel)
        addSubview(scrollMainStackView)
        scrollMainStackView.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        drinkThumbImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollMainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            drinkThumbImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            drinkThumbImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            drinkThumbImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            drinkThumbImageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: drinkThumbImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            scrollMainStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            scrollMainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            scrollMainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            scrollMainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
     
            mainStackView.topAnchor.constraint(equalTo: scrollMainStackView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollMainStackView.leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollMainStackView.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollMainStackView.trailingAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollMainStackView.widthAnchor),
        ])
    }
}
