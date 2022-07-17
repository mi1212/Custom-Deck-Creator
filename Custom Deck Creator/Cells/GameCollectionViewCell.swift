//
//  DecksCollectionViewCell.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 30.05.2022.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UIView
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = UIColor(named: "light")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

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
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])

    }
    
    func setupCell(indexOfDeckImage: Int) {
        imageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[indexOfDeckImage].cover)
    }
    
}
