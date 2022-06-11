//
//  DecksCollectionViewCell.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 30.05.2022.
//

import UIKit

class DecksCollectionViewCell: UICollectionViewCell {
    
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
        
        let inset: CGFloat = 1
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
        ])
        
        //        NSLayoutConstraint.activate([
        //            image.topAnchor.constraint(equalTo: imageView.topAnchor, constant: inset),
        //            image.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -inset),
        //            image.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: inset),
        //            image.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -inset),
        //        ])
    }
    
    
    
    //MARK: - UIView
    
    //    private lazy var imageView: UIView = {
    //        let outerView = UIView()
    //        outerView.clipsToBounds = true
    //        outerView.backgroundColor = UIColor(named: "dark 50%")
    //
    //        outerView.layer.shadowRadius = 5
    //        outerView.layer.shadowOpacity = 0.3
    //
    //        outerView.translatesAutoresizingMaskIntoConstraints = false
    //        return outerView
    //    }()
    
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
    
    
    
    func setupCell(name: String, index: Int) {
        imageView.image = UIImage(named: name)
    }
    
}
