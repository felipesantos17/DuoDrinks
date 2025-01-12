//
//  SearchViewController.swift
//  DuoDrinks
//
//  Created by Felipe Santos on 27/11/24.
//

import UIKit
import Alamofire

final class SearchViewController: UIViewController {
    
    private let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php"
    private var categoryType: CategoriesType?

    @IBOutlet weak var searchTextField: UITextField?
    @IBOutlet weak var searchButton: UIButton?
    @IBOutlet weak var resultSearchCollectionView: UICollectionView?
    private var drinks: [Drink] = []
    private var resultSearch: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSearchButton()
        configDelegates()
    }
    
    public func configCategoryTypeSelected(_ category: CategoriesType) {
        self.categoryType = category
    }
    
    private func configDelegates() {
        searchTextField?.delegate = self
        resultSearchCollectionView?.delegate = self
        resultSearchCollectionView?.dataSource = self
        resultSearchCollectionView?.register(ResultSearchCollectionViewCell.self, forCellWithReuseIdentifier: ResultSearchCollectionViewCell.identifier)
    }
    
    private func configSearchButton() {
        let action = UIAction { [weak self] _ in
            self?.startSearch()
        }
        
        searchButton?.addAction(action, for: .touchUpInside)
    }
    
    private func startSearch() {
        guard let value = searchTextField?.text else {
            showAlert("Write before starting a search")
            return
        }
        fetchDrink(value)
    }
    
    private func fetchDrink(_ value: String) {
        guard let categoryType = categoryType else {
            return
        }
        let parameters = [categoryType.typeSearch: value]
        
        switch categoryType {
        case .byName, .byFirstLetter:
            AF.request(baseURL, parameters: parameters).responseDecodable(of: DrinksResponse.self) { [weak self] response in
                    switch response.result {
                    case let .success(value):
                        if let drinks = value.drinks {
                            self?.resultSearch = drinks.map { $0.strDrink ?? "" }
                            self?.drinks = drinks
                            self?.resultSearchCollectionView?.reloadData()
                            return
                        }
                        self?.resultSearch.append("no results for the search")
                    case let .failure(error):
                        self?.showAlert(error.localizedDescription)
                    }
            }
        }
    }
    
    private func callDetailDrink(_ drink: Drink?) {
        let sendItems = joinTheitemsAndMeasurements(drink)
        let vc = DrinkDetailViewController(drink: drink, sendItems)
       
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showAlert(_ message: String = "Error") {
        let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        navigationController?.present(alert, animated: true)
    }
    
    private func joinTheitemsAndMeasurements(_ drink: Drink?) -> [String] {
        let keyIngredient: String = "strIngredient"
        let keyMeasure: String = "strMeasure"
        var allIngredients: [Int: String] = [:]
        var allMeasurements: [Int: String] = [:]
        var allItems: [String] = []
        
        guard let drink else { return allItems }
        
        let mirroDrink = Mirror(reflecting: drink)
        for stepInstruction in mirroDrink.children {
            if let label = stepInstruction.label {
                if label.starts(with: keyIngredient), let ingredient = stepInstruction.value as? String, !ingredient.isEmpty {
                    if let index = Int(label.dropFirst(keyIngredient.count)) {
                        allIngredients.updateValue(ingredient, forKey: index)
                    }
                }
                if label.starts(with: keyMeasure), let measurement = stepInstruction.value as? String, !measurement.isEmpty {
                    if let index = Int(label.dropFirst(keyMeasure.count)) {
                        allMeasurements.updateValue(measurement, forKey: index)
                    }
                }
            }
        }
        
        for number in 1...allIngredients.count {
            if let ingredient = allIngredients[number] {
                if let measure = allMeasurements[number] {
                    allItems.append("\(ingredient) - \(measure)")
                   
                } else {
                    allItems.append("\(ingredient)")
                }
            }
        }

        return allItems
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let categoryType = categoryType else {
            return true
        }
        switch categoryType {
            case .byFirstLetter:
                let currentText = textField.text ?? ""
                let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
                return updatedText.count < 2
            default:
                return true
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callDetailDrink(drinks[indexPath.row])
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultSearch.count == 0 ? 1 : resultSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultSearchCollectionViewCell.identifier, for: indexPath) as? ResultSearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if resultSearch.isEmpty {
            cell.configTitleCell("Empty")
            return cell
        }
        
        cell.configTitleCell(resultSearch[indexPath.row])
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.size.width, height: 48)
    }
}
