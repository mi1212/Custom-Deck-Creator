//
//  DeckCollectionViewCell.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 02.06.2022.
//

import UIKit

class DeckCollectionViewCell: UICollectionViewCell {
        
    private var indexRow = ""
    private var indexDeck = ""
    private var cardIsInverted = false
    var isPressed = false
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = false
        image.layer.cornerRadius = GamesViewController.customCornerRadius*2
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
    
    
    
    //MARK: - UIView
    
    func setupCell(name: String, index: Int, indexDeck: String) {
        imageView.image = UIImage(named: name)
        self.indexRow = String(index)
        self.indexDeck = indexDeck
    }
    
}
