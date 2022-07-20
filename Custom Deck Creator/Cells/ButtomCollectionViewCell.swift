//
//  ButtomCollectionViewCell.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 14.07.2022.
//

import UIKit

class ButtomCollectionViewCell: UICollectionViewCell {
    let index = ""
    
    lazy var titleView: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor(named: "light")
        title.textColor = UIColor(named: "dark")
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 1
        title.textAlignment = .center
        return title
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor(named: "dark")
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - layout
    
    private func layout() {

        contentView.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    
    //MARK: - UIView
    
    func setupCell(name: String, index: String) {
        
    }
}
