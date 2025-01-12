//
//  CategoriesType.swift
//  DuoDrinks
//
//  Created by Felipe Santos on 01/12/24.
//

public enum CategoriesType {
    case byName
    case byFirstLetter

    var title: String {
        switch self {
        case .byName: "Search cocktail by name"
        case .byFirstLetter: "List all cocktails by first letter"
        }
    }

    var typeSearch: String {
        switch self {
        case .byName: "s"
        case .byFirstLetter: "f"
        }
    }
}
