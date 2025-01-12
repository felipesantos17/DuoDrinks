//
//  SystemExtensions.swift
//  DuoDrinks
//
//  Created by Felipe Santos on 03/12/24.
//

import UIKit

extension UIImageView {
    
    func downloadImage(form url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mineType = response?.mimeType, mineType.hasPrefix("image"),
                let data, error == nil,
                let image = UIImage(data: data)
            else {
                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage(named: "deafult-image.jpg")
                }
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func loadImage(from link: String?, contentMode mode: ContentMode = .scaleToFill) {
        contentMode = mode
        guard let link, let url = URL(string: link) else {
            self.image = UIImage(named: "deafult-image.jpg")
            return
        }
        downloadImage(form: url, contentMode: mode)
    }
}

extension NSMutableAttributedString {
    func bold(_ value: String, size: CGFloat = 17, color: UIColor = .black) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: size, weight: .bold),
            .foregroundColor: color
        ]

        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    func normal(_ value: String, size: CGFloat = 17, color: UIColor = .black) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: size),
            .foregroundColor: color
        ]

        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}
