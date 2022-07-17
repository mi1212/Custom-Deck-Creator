//
//  CollectionViewCell.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 30.05.2022.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - layout
    
    private func layout() {
        contentView.addSubview(imageView)
        self.layer.borderColor = UIColor.darkGray.cgColor
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    
    
    //MARK: - UIView
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.backgroundColor = UIColor(named: "light")
        image.sizeToFit()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func setupCell(indexOfGameImage: Int) {
        imageView.image = UIImage(named: gamesArray[indexOfGameImage].cover)
    }
    
}

