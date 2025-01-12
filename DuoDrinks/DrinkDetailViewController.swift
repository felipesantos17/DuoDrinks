//
//  DrinkDetailViewController.swift
//  DuoDrinks
//
//  Created by Felipe Santos on 03/12/24.
//

import UIKit

class DrinkDetailViewController: UIViewController {

    private lazy var drinkView: DrinkDetailView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = drinkView
    }
    
    init(drink: Drink?, _ items: [String]) {
        super.init(nibName: nil, bundle: nil)
        drinkView.configure(with: drink, items)
        navigationItem.title = drink?.strDrink?.uppercased()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    
}
