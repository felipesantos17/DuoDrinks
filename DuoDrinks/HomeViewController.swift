//
//  HomeViewController.swift
//  DuoDrinks
//
//  Created by Felipe Santos on 01/12/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var categoriesCollectionView: UICollectionView?
    
    private var categoriesType: [CategoriesType] = [.byName, .byFirstLetter]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Choose a category to search for your drink"
        startConfigCollectionView()
    }
    
    private func startConfigCollectionView() {
        let nibCell = UINib(nibName: SearchCategoryCollectionViewCell.identifier, bundle: nil)
        categoriesCollectionView?.register(nibCell, forCellWithReuseIdentifier: SearchCategoryCollectionViewCell.identifier)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoriesType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCategoryCollectionViewCell.identifier, for: indexPath) as? SearchCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.titleCustomLabel?.text = categoriesType[indexPath.row].title

        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SearchController") as? SearchViewController else {
            return print("Error: Cannot instantiate SearchViewController")
        }
        
        vc.navigationItem.title = categoriesType[indexPath.row].title
        vc.configCategoryTypeSelected(categoriesType[indexPath.row])
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 12, left: .zero, bottom: .zero, right: .zero)
    }
}
