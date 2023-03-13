//
//  UIImageView+Extensions.swift
//  UsersAC
//
//  Created by Amanda Rosa on 2023-03-06.
//

import UIKit

extension UIImageView {
    public func downloadImageFrom(_ url: String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
