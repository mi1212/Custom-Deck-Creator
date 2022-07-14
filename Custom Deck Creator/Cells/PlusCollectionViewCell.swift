//
//  EmptyCollectionViewCell.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 30.05.2022.
//

import UIKit

class PlusCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .yellow
        layout()
        
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1
        self.layer.opacity = 0.1
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - layout
    
    private func layout() {
        contentView.addSubview(imageView)
        
//        let inset: CGFloat = 80
        
        let inset: CGFloat = self.contentView.layer.bounds.height/2.5
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    
    
    //MARK: - UIView
    private var imageView: UIImageView = {
        let cell = UIImageView()
        cell.layer.opacity = 0.1
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.image = UIImage(named: "add")
        cell.contentMode = .scaleAspectFit
        cell.isUserInteractionEnabled = true
        return cell
    }()
    
}

