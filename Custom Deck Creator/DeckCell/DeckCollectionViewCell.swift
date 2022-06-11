//
//  DeckCollectionViewCell.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 02.06.2022.
//

import UIKit

protocol DeckCollectionViewCellDelegate: AnyObject {
    func changeImage(cardIndex: String)
    func changeImageToBack(indexDeck: String)
}

class DeckCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: DeckCollectionViewCellDelegate?
    
    private var indexRow = ""
    private var indexDeck = ""
    private var cardIsInverted = false
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .white
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 1
        image.layer.shadowOffset = CGSize.zero
        image.layer.shadowRadius = 10
        image.layer.shadowPath = UIBezierPath(roundedRect: image.bounds, cornerRadius: 10).cgPath
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setupGesture()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGesture() {
        self.imageView.isUserInteractionEnabled = true
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        self.imageView.addGestureRecognizer(doubleTap)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tap.numberOfTapsRequired = 1
        self.imageView.addGestureRecognizer(tap)
        
        tap.require(toFail: doubleTap)
        
        
    }
    
    @objc func tapped() {
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .autoreverse) {
            self.delegate?.changeImageToBack(indexDeck: self.indexDeck)
            self.imageView.layer.opacity = 0.7
            self.imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            
            
            self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.imageView.layer.opacity = 1
        }
    }
    
    @objc func doubleTapped() {
        
        print("double tap")
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.delegate?.changeImage(cardIndex: self.indexDeck + self.indexRow)
            self.imageView.transform = CGAffineTransform(scaleX: 0.01, y: 1)
        } completion: { _ in
//            let imageTemp =
            
            self.imageView.image = UIImage(named: "card" + self.indexDeck + self.indexRow)
//            self.imageView.image = UIImage(named: "card" + self.indexDeck + self.indexRow)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                self.imageView.layer.opacity = 1
                self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    //MARK: - layout
    
    private func layout() {
        contentView.addSubview(imageView)
        
        let inset: CGFloat = 1
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
        ])
    }
    
    
    
    //MARK: - UIView
    
    func setupCell(name: String, index: Int, indexDeck: String) {
        imageView.image = UIImage(named: name)
        self.indexRow = String(index)
        self.indexDeck = indexDeck
    }
    
}
