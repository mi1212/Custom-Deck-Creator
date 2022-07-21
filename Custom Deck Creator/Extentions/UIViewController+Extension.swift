//
//  UIViewController+Extension.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 11.07.2022.
//

import UIKit

extension UIViewController {
    func setupNavigationBar(title: String) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "dark") as Any]
        self.navigationController?.navigationBar.tintColor = UIColor(named: "dark")
    }
}
