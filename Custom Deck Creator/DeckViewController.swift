//
//  DeckViewController.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 31.05.2022.
//

import UIKit

class DeckViewController: UIViewController {

    var indexDeck: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "light")
        setup()
    }
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "dark 50%")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var deckView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "dark 75%")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setup() {
        self.view.addSubview(cardsCollectionView)
        self.view.addSubview(cardView)
        self.view.addSubview(deckView)
        self.view.addSubview(buttomsView)
        
        
        buttomsView.addSubview(buttomsStack)
        
        buttomsStack.addArrangedSubview(copyButtom)
        buttomsStack.addArrangedSubview(editButtom)
        buttomsStack.addArrangedSubview(reloadButtom)
        buttomsStack.addArrangedSubview(settingsButtom)
        
        let inset: CGFloat = 8
        
        NSLayoutConstraint.activate([
            cardsCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            cardsCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            cardsCollectionView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/4),
            cardsCollectionView.bottomAnchor.constraint(equalTo: buttomsView.topAnchor)

        ])
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -self.view.bounds.width/2),
            cardView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            cardView.bottomAnchor.constraint(equalTo: cardsCollectionView.topAnchor, constant: -inset),

        ])
        
        NSLayoutConstraint.activate([
            deckView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            deckView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            deckView.leadingAnchor.constraint(equalTo: cardView.trailingAnchor),
            deckView.bottomAnchor.constraint(equalTo: cardsCollectionView.topAnchor, constant: -inset),
        ])
        
        NSLayoutConstraint.activate([
//            buttomsStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            buttomsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset * 10),
            buttomsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset * 10),
            buttomsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -inset),
            buttomsView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            buttomsStack.topAnchor.constraint(equalTo: buttomsView.topAnchor),
            buttomsStack.trailingAnchor.constraint(equalTo: buttomsView.trailingAnchor, constant: -inset * 15),
            buttomsStack.leadingAnchor.constraint(equalTo: buttomsView.leadingAnchor, constant: inset * 15),
            buttomsStack.bottomAnchor.constraint(equalTo: buttomsView.bottomAnchor)
        ])
        

        
        
        setupCornerAndShadowOfStack(buttomsStack)
        
        print("\(self.view.bounds.width/2)")
        
    }
    
    private lazy var buttomsView: UIView = {
        let view = UIView()
//        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttomsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = UIColor(named: "light")
        stack.alignment = .center
//        stack.sizeToFit()
        stack.layer.opacity = 0.5
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        
        stack.layer.borderWidth = 0.5
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.cornerRadius = 10
        stack.clipsToBounds = true
        stack.distribution = .fillEqually
        return stack
    }()
    
    func setupCornerAndShadowOfStack(_ view: UIView) {
        view.layer.cornerRadius = GamesViewController.customCornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = GamesViewController.customCornerRadius
        view.layer.shadowOpacity = 0.7
        view.layer.masksToBounds = false
    }
    
    func setupCornerAndShadowOfCell(_ collectionView: UICollectionView, _ cell: UICollectionViewCell ) {
        cell.contentView.layer.cornerRadius = GamesViewController.customCornerRadius
        cell.contentView.layer.masksToBounds = true
        
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
//        cell.layer.shadowRadius = ViewController.customCornerRadius
//        cell.layer.shadowOpacity = 0.2
//        cell.layer.masksToBounds = false
//        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    
    private lazy var copyButtom: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.sizeToFit()
//        image.layer.borderWidth = 1
//        image.layer.borderColor = UIColor.lightGray.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "copy")
        return image
    }()
    
    private lazy var editButtom: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.sizeToFit()
//        image.layer.borderWidth = 1
//        image.layer.borderColor = UIColor.lightGray.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "edit")
        return image
    }()
    
    private lazy var reloadButtom: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.sizeToFit()
//        image.layer.borderWidth = 1
//        image.layer.borderColor = UIColor.lightGray.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "reload")
        return image
    }()
    
    private lazy var settingsButtom: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.sizeToFit()
//        image.layer.borderWidth = 1
//        image.layer.borderColor = UIColor.lightGray.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "settings")
        return image
    }()
    
    private lazy var cardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "light")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.allowsSelection = true
        collection.isPrefetchingEnabled = true
        
        collection.register(DecksCollectionViewCell.self, forCellWithReuseIdentifier: DecksCollectionViewCell.identifire)
        collection.register(PlusCollectionViewCell.self, forCellWithReuseIdentifier: PlusCollectionViewCell.identifire)
        return collection
    }()
    
}



extension DeckViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DecksCollectionViewCell.identifire, for: indexPath) as! DecksCollectionViewCell
        cell.setupCell(name: "cover" + indexDeck, index: indexPath.row)
        
        setupCornerAndShadowOfCell(collectionView, cell)

        return cell
        
    }
}

extension DeckViewController: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat { return 20 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - inset * 8 ) / 7
        
        return CGSize(width: width, height: width * 1.3)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
}



