//
//  DeckViewController.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 31.05.2022.
//

import UIKit

class DeckViewController: UIViewController {
    
    var indexDeck: String = ""
    
    // колода карт
    private lazy var deckCardsCollectionView: UICollectionView = {
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
        collection.register(DeckCollectionViewCell.self, forCellWithReuseIdentifier: DeckCollectionViewCell.identifire)
        collection.register(PlusCollectionViewCell.self, forCellWithReuseIdentifier: PlusCollectionViewCell.identifire)
        return collection
    }()
    // карты в руке игрока
    private lazy var handCardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "dark 50%")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.allowsSelection = true
        collection.isPrefetchingEnabled = true
        collection.register(DeckCollectionViewCell.self, forCellWithReuseIdentifier: DeckCollectionViewCell.identifire)
        collection.register(PlusCollectionViewCell.self, forCellWithReuseIdentifier: PlusCollectionViewCell.identifire)
        return collection
    }()
    
    lazy var cardImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
//    private lazy var buttomsView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .black
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    private lazy var buttomsStack: UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.backgroundColor = UIColor(named: "light")
//        stack.alignment = .center
//        //        stack.sizeToFit()
//        stack.layer.opacity = 0.5
//        stack.distribution = .fillProportionally
//        stack.axis = .horizontal
//        stack.layer.borderWidth = 0.5
//        stack.layer.borderColor = UIColor.lightGray.cgColor
//        stack.layer.cornerRadius = 10
//        stack.clipsToBounds = true
//        stack.distribution = .fillEqually
//        return stack
//    }()
//    func setupCornerAndShadowOfStack(_ view: UIView) {
//        view.layer.cornerRadius = GamesViewController.customCornerRadius
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 10)
//        view.layer.shadowRadius = GamesViewController.customCornerRadius
//        view.layer.shadowOpacity = 0.7
//        view.layer.masksToBounds = false
//    }
//
//    private lazy var copyButtom: UIImageView = {
//        let image = UIImageView()
//        image.contentMode = .scaleAspectFit
//        image.layer.masksToBounds = true
//        image.sizeToFit()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.image = UIImage(named: "copy")
//        return image
//    }()
//
//    private lazy var editButtom: UIImageView = {
//        let image = UIImageView()
//        image.contentMode = .scaleAspectFit
//        image.layer.masksToBounds = true
//        image.sizeToFit()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.image = UIImage(named: "edit")
//        return image
//    }()
//
//    private lazy var reloadButtom: UIImageView = {
//        let image = UIImageView()
//        image.contentMode = .scaleAspectFit
//        image.layer.masksToBounds = true
//        image.sizeToFit()
//         image.translatesAutoresizingMaskIntoConstraints = false
//        image.image = UIImage(named: "reload")
//        return image
//    }()
//
//    private lazy var settingsButtom: UIImageView = {
//        let image = UIImageView()
//        image.contentMode = .scaleAspectFit
//        image.layer.masksToBounds = true
//        image.sizeToFit()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.image = UIImage(named: "settings")
//        return image
//    }()
//    private lazy var cardView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(named: "dark 50%")
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    private lazy var imageView: UIView = {
//        let view = UIView()
////        view.backgroundColor = UIColor(named: "dark")
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.clipsToBounds = true
//        return view
//    }()
//
//    private lazy var cardLabelFirstView: UILabel = {
//        let lable = UILabel()
//        lable.text = "Взять в руку"
//        lable.textAlignment = .center
//        lable.font = UIFont.systemFont(ofSize: 28)
//        lable.backgroundColor = UIColor(named: "dark 75%")
//        lable.layer.cornerRadius = GamesViewController.customCornerRadius
//        lable.clipsToBounds = true
//        lable.layer.borderColor = UIColor(named: "dark")?.cgColor
//        lable.translatesAutoresizingMaskIntoConstraints = false
//        return lable
//    }()
//
//    private lazy var cardLabelSecondView: UILabel = {
//        let lable = UILabel()
//        lable.text = "Убрать из колоды"
//        lable.textAlignment = .center
//        lable.font = UIFont.systemFont(ofSize: 28)
//        lable.backgroundColor = UIColor(named: "dark 75%")
//        lable.layer.cornerRadius = GamesViewController.customCornerRadius
//        lable.clipsToBounds = true
//        lable.layer.borderColor = UIColor(named: "dark")?.cgColor
//        lable.translatesAutoresizingMaskIntoConstraints = false
//        return lable
//    }()
//
//    private lazy var cardLabelThirdView: UILabel = {
//        let lable = UILabel()
//        lable.text = "Вернуть в колоду"
//        lable.textAlignment = .center
//        lable.font = UIFont.systemFont(ofSize: 28)
//        lable.backgroundColor = UIColor(named: "dark 75%")
//        lable.layer.cornerRadius = GamesViewController.customCornerRadius
//        lable.clipsToBounds = true
//        lable.layer.borderColor = UIColor(named: "dark")?.cgColor
//        lable.translatesAutoresizingMaskIntoConstraints = false
//        return lable
//    }()
//
//    private var labelStack: UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.spacing = 8
//        stack.distribution = .fillEqually
//        return stack
//    }()
//
//    private var cardStack: UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .horizontal
//        stack.distribution = .equalSpacing
//
//        return stack
//    }()

    private lazy var imageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "dark 50%")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "dark 75%")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var deckView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "dark")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "light")
        setup()
    }
    
    private func setup() {
        self.view.addSubview(deckCardsCollectionView)
        self.view.addSubview(imageView)
        self.view.addSubview(buttonsView)
        self.view.addSubview(handCardsCollectionView)
        
        
        
//        self.view.addSubview(cardView)
//        self.view.addSubview(cardStack)
//
//        self.view.addSubview(buttomsView)
//
//        buttomsView.addSubview(buttomsStack)
//
//        cardView.addSubview(cardStack)
//
//        cardStack.addArrangedSubview(imageView)
//
//        imageView.addSubview(cardImageView)
//
//        cardStack.addArrangedSubview(labelStack)
//
//        labelStack.addArrangedSubview(cardLabelFirstView)
//        labelStack.addArrangedSubview(cardLabelSecondView)
//        labelStack.addArrangedSubview(cardLabelThirdView)
//
//        buttomsStack.addArrangedSubview(copyButtom)
//        buttomsStack.addArrangedSubview(editButtom)
//        buttomsStack.addArrangedSubview(reloadButtom)
//        buttomsStack.addArrangedSubview(settingsButtom)
//
//        let inset: CGFloat = 8
        
        NSLayoutConstraint.activate([
            deckCardsCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            deckCardsCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            deckCardsCollectionView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/4),
            deckCardsCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: self.view.bounds.width/4),
            imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            imageView.bottomAnchor.constraint(equalTo: deckCardsCollectionView.topAnchor, constant: -inset),
        ])
        
        NSLayoutConstraint.activate([
            buttonsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            buttonsView.widthAnchor.constraint(equalToConstant: self.view.bounds.width/4),
            buttonsView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: inset),
            buttonsView.bottomAnchor.constraint(equalTo: deckCardsCollectionView.topAnchor, constant: -inset),
        ])
    
        NSLayoutConstraint.activate([
            handCardsCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            handCardsCollectionView.widthAnchor.constraint(equalToConstant: self.view.bounds.width/2),
            handCardsCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            handCardsCollectionView.leadingAnchor.constraint(equalTo: buttonsView.trailingAnchor, constant: inset),
            handCardsCollectionView.bottomAnchor.constraint(equalTo: deckCardsCollectionView.topAnchor, constant: -inset),
        ])
        
//        NSLayoutConstraint.activate([
//            cardImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
//            cardImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
//            cardImageView.topAnchor.constraint(equalTo: imageView.topAnchor),
//            cardImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            cardView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -self.view.bounds.width/2.5),
//            cardView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            cardView.bottomAnchor.constraint(equalTo: cardsCollectionView.topAnchor, constant: -inset),
//
//        ])
//
//        NSLayoutConstraint.activate([
//            labelStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: inset),
//            labelStack.trailingAnchor.constraint(equalTo: deckView.leadingAnchor, constant: -inset),
//        ])
//
//        NSLayoutConstraint.activate([
//            cardStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: inset),
//            cardStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: inset),
//            cardStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -inset),
//            cardStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -inset),
//
//            labelStack.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.3 - 4 * inset)
//        ])
//
//        NSLayoutConstraint.activate([
//            buttomsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset * 10),
//            buttomsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset * 10),
//            buttomsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -inset),
//            buttomsView.heightAnchor.constraint(equalToConstant: 30)
//        ])
//
//        NSLayoutConstraint.activate([
//            buttomsStack.topAnchor.constraint(equalTo: buttomsView.topAnchor),
//            buttomsStack.trailingAnchor.constraint(equalTo: buttomsView.trailingAnchor, constant: -inset * 15),
//            buttomsStack.leadingAnchor.constraint(equalTo: buttomsView.leadingAnchor, constant: inset * 15),
//            buttomsStack.bottomAnchor.constraint(equalTo: buttomsView.bottomAnchor)
//        ])
//
//        setupCornerAndShadowOfStack(buttomsStack)
    }
    
    func setupCornerAndShadowOfCell(_ collectionView: UICollectionView, _ cell: UICollectionViewCell ) {
        cell.contentView.layer.cornerRadius = GamesViewController.customCornerRadius
        cell.contentView.layer.masksToBounds = true
    }
}


extension DeckViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.deckCardsCollectionView {
                return 10
            } else {
                return 7
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.deckCardsCollectionView {
                let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: DeckCollectionViewCell.identifire, for: indexPath) as! DeckCollectionViewCell
            cellA.setupCell(name: "cover" + indexDeck, index: indexPath.row, indexDeck: indexDeck)
            cellA.delegate = self
            setupCornerAndShadowOfCell(collectionView, cellA)
                return cellA
            }

            else {
                let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: DeckCollectionViewCell.identifire, for: indexPath) as! DeckCollectionViewCell
                cellB.setupCell(name: "card" + indexDeck + String(indexPath.row), index: indexPath.row, indexDeck: indexDeck)
                cellB.delegate = self
                setupCornerAndShadowOfCell(collectionView, cellB)
                return cellB
            }
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckCollectionViewCell.identifire, for: indexPath) as! DeckCollectionViewCell
//        cell.setupCell(name: "cover" + indexDeck, index: indexPath.row, indexDeck: indexDeck)
//        cell.delegate = self
//        setupCornerAndShadowOfCell(collectionView, cell)
//
//        return cell
        
    }
}

extension DeckViewController: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat { return 20 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.deckCardsCollectionView {
            let width = (collectionView.bounds.width - inset * 8 ) / 7
            
            return CGSize(width: width, height: width * 1.3)
            }

            else {
                let width = (collectionView.bounds.width - inset * 4 ) / 3
                
                return CGSize(width: width, height: width * 1.3)
            }
        
        
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

extension DeckViewController: DeckCollectionViewCellDelegate {
    func changeImage(cardIndex: String) {
        
    }
    
    func changeImageToBack(indexDeck: String) {
        
    }
    
    
//    func changeImageToBack(indexDeck: String) {
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
//            self.cardImageView.layer.opacity = 0
//        } completion: { _ in
//
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
//                self.cardImageView.image = UIImage(named: "cover" + indexDeck)
//                self.cardImageView.layer.opacity = 1
//            }
//        }
//    }
//
//    func changeImage(cardIndex: String) {
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
//            self.cardImageView.layer.opacity = 0
//        } completion: { _ in
//
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
//                self.cardImageView.image = UIImage(named: "card" + cardIndex)
//                self.cardImageView.layer.opacity = 1
//            }
//        }
//
//    }
    
    
}



