//
//  DeckCollectionViewCell.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 02.06.2022.
//

import UIKit

class DeckCollectionViewCell: UICollectionViewCell {
    
    let deck = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!]
    
    //MARK: - UIView
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = false
        image.layer.cornerRadius = GamesViewController.customCornerRadius*2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var holdImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.backgroundColor = .white
        image.image = UIImage(systemName: "pin")
        image.layer.opacity = 0
        image.tintColor = .black
        image.transform = CGAffineTransform(rotationAngle: 45)
        image.clipsToBounds = true
        image.layer.cornerRadius = GamesViewController.customCornerRadius
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
        contentView.addSubview(holdImageView)
        
        NSLayoutConstraint.activate([
            holdImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: GamesViewController.customCornerRadius/2),
            holdImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -GamesViewController.customCornerRadius/2),
            holdImageView.heightAnchor.constraint(equalToConstant: self.layer.bounds.height/5),
            holdImageView.widthAnchor.constraint(equalTo: holdImageView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func setupCell(indexOfCardImage: Int) {
let card = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexOfCardImage]
        
        switch card.isFlipedOver {
        case false:
            imageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cover)
        case true:
            imageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexOfCardImage].nameOfImage)
        }
        
        if card.isPressed {
            self.layer.opacity = 0.8
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } else {
            self.layer.opacity = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        if card.isPined {
            self.holdImageView.layer.opacity = 0.7
        } else {
            self.holdImageView.layer.opacity = 0
        }
 
    }
    
    func setupHandCell(indexOfCardImage: Int) {
        let card = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray[indexOfCardImage]

        imageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray[indexOfCardImage].nameOfImage)

        if card.isPined {
            self.holdImageView.layer.opacity = 0.7
        } else {
            self.holdImageView.layer.opacity = 0
        }
 
    }
    func setupDiscardCardCell(indexOfCardImage: Int) {
        let card = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].dischardCardArray[indexOfCardImage]
        
        switch card.isFlipedOver {
        case false:
            imageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cover)
        case true:
            imageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].dischardCardArray[indexOfCardImage].nameOfImage)
        }

        if card.isPined {
            self.holdImageView.layer.opacity = 0.7
        } else {
            self.holdImageView.layer.opacity = 0
        }
 
    }
    
}
