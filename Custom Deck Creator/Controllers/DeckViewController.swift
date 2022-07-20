//
//  DeckViewController.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 31.05.2022.
//

import UIKit
import CloudKit

class DeckViewController: UIViewController {
    
    static var indexOfDeck: Int?            // индекс колоды
    
    // свойство чтобы понимать что карта выбрана(нажата) в руке(true) или в колоде(false)
    var isSelectedCardInHand: Bool = false
    // indexPath выбранной карты
    var indexOfSelectedCard: Int?
    
    var qtyOfCardsInDeck = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsQty
    
    var qtyOfCardsInHand = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray.count
    
    var cellShadowOpacity: Float = 0.3
    
    // колода карт
    private lazy var deckCardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "dark 50%")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = false
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
        collection.register(DeckCollectionViewCell.self, forCellWithReuseIdentifier: DeckCollectionViewCell.identifire)
        collection.register(PlusCollectionViewCell.self, forCellWithReuseIdentifier: PlusCollectionViewCell.identifire)
        return collection
    }()
    // кнопки управления
    private lazy var buttomsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "dark 50%")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = false
        collection.register(ButtomCollectionViewCell.self, forCellWithReuseIdentifier: ButtomCollectionViewCell.identifire)
        return collection
    }()
    // вью для картинки выбранной карты
    private lazy var imageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "dark 50%")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // вью для дизайна анимации при нажатии на карту из колоды(закрашивает грань между кнопками и колодой)
    private lazy var designeDeckView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "dark 50%")
        view.layer.opacity = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // вью для дизайна анимации при нажатии на карту из колоды(закрашивает грань между кнопками и колодой)
    private lazy var designeDeckCornerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "dark 50%")
        view.layer.opacity = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // вырезает из первой вью для дизайна чтобы сделать скругление справа
    private lazy var designeDeckCorenerRightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "light")
        view.layer.opacity = 1
        view.clipsToBounds = true
        view.layer.cornerRadius = GamesViewController.customCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // вью для дизайна анимации при нажатии на карту из руки(закрашивает грань между кнопками и картами в руке)
    private lazy var designeHandView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "dark 50%")
        view.layer.opacity = 0
        view.layer.cornerRadius = GamesViewController.customCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // картинка выбраноой карты из колоды
    lazy var cardImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "light")
        setup()
        
        setupNavigationBar(title: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].name)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(title: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].name)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.title = ""
    }
    
    private func setup() {
        self.view.addSubview(designeDeckView)
        self.view.addSubview(designeDeckCornerView)
        self.view.addSubview(designeDeckCorenerRightView)
        
        self.view.addSubview(designeHandView)
        
        self.view.addSubview(handCardsCollectionView)
        self.view.addSubview(deckCardsCollectionView)
        self.view.addSubview(imageView)
        imageView.addSubview(cardImageView)
        self.view.addSubview(buttomsCollectionView)
        
        
        
        
        self.navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        cardImageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cover)
        
        let viewsArray = [deckCardsCollectionView, imageView, buttomsCollectionView, handCardsCollectionView, cardImageView, designeDeckView, designeHandView]
        
        let _: [()] = viewsArray.map{$0.layer.cornerRadius = GamesViewController.customCornerRadius}
        
        NSLayoutConstraint.activate([
            designeDeckView.topAnchor.constraint(equalTo: buttomsCollectionView.topAnchor),
            designeDeckView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            designeDeckView.trailingAnchor.constraint(equalTo: buttomsCollectionView.trailingAnchor),
            designeDeckView.bottomAnchor.constraint(equalTo: deckCardsCollectionView.bottomAnchor, constant: -GamesViewController.customCornerRadius),
        ])
        
        NSLayoutConstraint.activate([
            designeDeckCornerView.topAnchor.constraint(equalTo: buttomsCollectionView.centerYAnchor),
            designeDeckCornerView.leadingAnchor.constraint(equalTo: buttomsCollectionView.centerXAnchor),
            designeDeckCornerView.trailingAnchor.constraint(equalTo: handCardsCollectionView.centerXAnchor),
            designeDeckCornerView.bottomAnchor.constraint(equalTo: deckCardsCollectionView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            designeDeckCorenerRightView.topAnchor.constraint(equalTo: buttomsCollectionView.topAnchor),
            designeDeckCorenerRightView.leadingAnchor.constraint(equalTo: buttomsCollectionView.trailingAnchor),
            designeDeckCorenerRightView.trailingAnchor.constraint(equalTo: handCardsCollectionView.trailingAnchor),
            designeDeckCorenerRightView.bottomAnchor.constraint(equalTo: deckCardsCollectionView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            designeHandView.topAnchor.constraint(equalTo: buttomsCollectionView.topAnchor),
            designeHandView.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor),
            designeHandView.trailingAnchor.constraint(equalTo: handCardsCollectionView.trailingAnchor),
            designeHandView.bottomAnchor.constraint(equalTo: buttomsCollectionView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            deckCardsCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            deckCardsCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            deckCardsCollectionView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/4),
            deckCardsCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -inset)
        ])
        
        NSLayoutConstraint.activate([
            handCardsCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            handCardsCollectionView.widthAnchor.constraint(equalToConstant: self.view.bounds.width*0.4),
            handCardsCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            handCardsCollectionView.leadingAnchor.constraint(equalTo: buttomsCollectionView.trailingAnchor, constant: inset),
            handCardsCollectionView.bottomAnchor.constraint(equalTo: deckCardsCollectionView.topAnchor, constant: -inset),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: buttomsCollectionView.leadingAnchor, constant: -inset),
            imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            imageView.bottomAnchor.constraint(equalTo: deckCardsCollectionView.topAnchor, constant: -inset),
        ])
          
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: inset),
            cardImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -inset),
            cardImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: inset),
            cardImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -inset),
        ])
        
        NSLayoutConstraint.activate([
            buttomsCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            buttomsCollectionView.widthAnchor.constraint(equalToConstant: self.view.bounds.width*0.2),
            buttomsCollectionView.trailingAnchor.constraint(equalTo: handCardsCollectionView.leadingAnchor, constant: -inset),
            buttomsCollectionView.bottomAnchor.constraint(equalTo: deckCardsCollectionView.topAnchor, constant: -inset),
        ])
        
        
        
    }
    
    func setupCornerAndShadowOfCell(_ collectionView: UICollectionView, _ cell: UICollectionViewCell ) {
        cell.contentView.layer.masksToBounds = true
        
        cell.contentView.layer.cornerRadius = GamesViewController.customCornerRadius
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = GamesViewController.customCornerRadius
        cell.layer.shadowOpacity = cellShadowOpacity
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
    }

    private lazy var addBarButtonItem: UIBarButtonItem = {

        return UIBarButtonItem(title: "Сброшенные карты", style: .plain, target: self, action: #selector(addBarButtomTaped))

//        return UIBarButtonItem(customView: UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20)))
    }()
    
    @objc private func addBarButtomTaped() {
        
        let discardCardsVC = DiscardCardsViewController()
//        self.navigationController?.pushViewController(discardCardsVC, animated: true)
        self.navigationController?.present(discardCardsVC, animated: true)
    }

    func designeThenChooseDeckCard(_ opacity:  Float) {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn) {
            self.designeDeckView.layer.opacity = opacity
            self.designeDeckCornerView.layer.opacity = opacity
        }
    }
    
    func designeThenChooseHandCard(_ opacity:  Float) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.designeHandView.layer.opacity = opacity
            
        }
    }
}

extension DeckViewController: UICollectionViewDataSource {
    
    var numbersButtoms: CGFloat { CGFloat(CardButtoms.allCases.count)}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch collectionView {
        case deckCardsCollectionView:
            return qtyOfCardsInDeck
        case handCardsCollectionView:
            return qtyOfCardsInHand
        case buttomsCollectionView:
            return CardButtoms.allCases.count
            
        default:
            return 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case deckCardsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckCollectionViewCell.identifire, for: indexPath) as! DeckCollectionViewCell
            
            cell.setupCell(indexOfCardImage: indexPath.row)
            setupCornerAndShadowOfCell(collectionView, cell)
            return cell
            
        case handCardsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckCollectionViewCell.identifire, for: indexPath) as! DeckCollectionViewCell

            cell.setupHandCell(indexOfCardImage: indexPath.row)
            setupCornerAndShadowOfCell(collectionView, cell)
            return cell
            
        case buttomsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtomCollectionViewCell.identifire, for: indexPath) as! ButtomCollectionViewCell
        
            setupCornerAndShadowOfCell(collectionView, cell)
            
            for i in 0...CardButtoms.allCases.count-1 {

                if i == indexPath.row {
                    cell.titleView.text = CardButtoms.allCases[i].rawValue
                }
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        switch collectionView {
        case deckCardsCollectionView:
            
            isSelectedCardInHand = false                // присваиваем статус карты не в руке
            
            indexOfSelectedCard = indexPath.row         //   присваиваем индекс выбранной ячейки
            
            if let cell = collectionView.cellForItem(at: indexPath) as? DeckCollectionViewCell {
                //переключение состояния выбора ячейки
                switch gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexOfSelectedCard!].isPressed {
                case false:
                    cell.layer.opacity = 0.8
                    cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    self.designeThenChooseDeckCard(1)
                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexOfSelectedCard!].isPressed.toggle()
                    if gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexOfSelectedCard!].isFlipedOver {
                        cardImageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexOfSelectedCard!].nameOfImage)
                    } else {
                        cardImageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cover )
                    }
                case true:
                    cell.layer.opacity = 1
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.designeThenChooseDeckCard(0)
                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexOfSelectedCard!].isPressed.toggle()
                    indexOfSelectedCard = nil
                }
                
                
                
            }
            
        case handCardsCollectionView:
            
            isSelectedCardInHand = true                 // присваиваем статус карты в руке
            
            indexOfSelectedCard = indexPath.row         //   присваиваем индекс выбранной ячейки
            
            if let cell = collectionView.cellForItem(at: indexPath) as? DeckCollectionViewCell {
                //переключение состояния выбора ячейки
                switch gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray[indexOfSelectedCard!].isPressed {
                case false:
                    cell.layer.opacity = 0.8
                    cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    
                    self.designeThenChooseHandCard(1)
                    
                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray[indexOfSelectedCard!].isPressed.toggle()
                    
                    cardImageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray[indexOfSelectedCard!].nameOfImage)
                    
                case true:
                    cell.layer.opacity = 1
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                    
                    self.designeThenChooseHandCard(0)
                    
                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray[indexOfSelectedCard!].isPressed.toggle()
                    
                    indexOfSelectedCard = nil
                }
            }
        
        case buttomsCollectionView:
            
            
            // анимация нажатия на кнопку действия
            let cell = buttomsCollectionView.cellForItem(at: indexPath) as! ButtomCollectionViewCell
            UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseInOut) {
                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } completion: { _ in
                UIView.animate(withDuration: 0.04, delay: 0, options: .curveEaseInOut) {
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                } completion: { _ in
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
            
            if let index = indexOfSelectedCard {  // при несоблюдении этого условия вылезает алерт что нужно выбрать карту

            switch cell.titleView.text {
                
            case "Закрепить":
   
                if !isSelectedCardInHand {
                    
                    if let cell = deckCardsCollectionView.cellForItem(at: IndexPath(row: index, section: 0) ) as? DeckCollectionViewCell {
                    
                    switch gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexOfSelectedCard!].isPined {
                    case false:
                        
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            cell.holdImageView.layer.opacity = 1
                            cell.holdImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                            cell.layer.opacity = 1
                            self.designeThenChooseDeckCard(0)
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[index].isPined.toggle()
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[index].isPressed.toggle()
                        } completion: { _ in
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                                cell.holdImageView.layer.opacity = 0.7
                                cell.holdImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                cell.holdImageView.transform = CGAffineTransform(rotationAngle: 45)
                                
                            } completion: { _ in
                                
                                self.deckCardsCollectionView.reloadData()
                                
                                self.indexOfSelectedCard = nil
                            }
                        }
                        
                    case true:
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            cell.holdImageView.layer.opacity = 0.2
                            cell.holdImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                            cell.layer.opacity = 1
                            self.designeThenChooseDeckCard(0)
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[index].isPined.toggle()
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[index].isPressed.toggle()
                        } completion: { _ in
                            
                            self.deckCardsCollectionView.reloadData()
                            self.indexOfSelectedCard = nil
                        }
                        
                    }
                    
                    }
                    
                } else {

                    if let cell = handCardsCollectionView.cellForItem(at: IndexPath(row: index, section: 0) ) as? DeckCollectionViewCell {
                    
                    switch gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray[indexOfSelectedCard!].isPined {
                    case false:
                        
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            cell.holdImageView.layer.opacity = 1
                            cell.holdImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                            cell.layer.opacity = 1
                            self.designeThenChooseHandCard(0)
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray[index].isPined.toggle()
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray[index].isPressed.toggle()
                        } completion: { _ in
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                                cell.holdImageView.layer.opacity = 0.7
                                cell.holdImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                cell.holdImageView.transform = CGAffineTransform(rotationAngle: 45)
                                
                            } completion: { _ in
                                
                                self.deckCardsCollectionView.reloadData()
                                self.indexOfSelectedCard = nil
                            }
                        }
                        
                    case true:
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            cell.holdImageView.layer.opacity = 0
                            cell.holdImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                            cell.layer.opacity = 1
                            self.designeThenChooseHandCard(0)
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray[index].isPined.toggle()
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray[index].isPressed.toggle()
                        } completion: { _ in
                            
                            self.deckCardsCollectionView.reloadData()
                            self.indexOfSelectedCard = nil
                        }
                    }
                    }
                }
  
            case "Перевернуть":

                if isSelectedCardInHand == false {
                    
                    
                    let cell = deckCardsCollectionView.cellForItem(at: IndexPath(row: index, section: 0) ) as! DeckCollectionViewCell
                    
                    switch gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[index].isFlipedOver {
                    case false:
                        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                            cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.9)
                            self.cardImageView.layer.opacity = 0
                        } completion: { _ in
                            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                                cell.imageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[index].nameOfImage)
                                self.designeThenChooseDeckCard(0)
                                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                            } completion: { _ in
                                UIView.animate(withDuration: 0.03, delay: 0, options: .curveEaseInOut) {
                                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    cell.layer.opacity = 1
                                    self.cardImageView.layer.opacity = 1
                                    self.cardImageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[self.indexOfSelectedCard!].nameOfImage)
                                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[index].isFlipedOver.toggle()
                                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[index].isPressed.toggle()
                                } completion: { _ in
                                    
                                    self.deckCardsCollectionView.reloadData()
                                    
                                    self.indexOfSelectedCard = nil
                                }
                            }
                        }

                    case true:
                        
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.9)
                            self.cardImageView.layer.opacity = 0
                        } completion: { _ in
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                                cell.imageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cover)
                                self.designeThenChooseDeckCard(0)
                                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                            } completion: { _ in
                                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    cell.layer.opacity = 1
                                    self.cardImageView.layer.opacity = 1
                                    self.cardImageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cover)
                                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[index].isFlipedOver.toggle()
                                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[index].isPressed.toggle()
                                } completion: { _ in
            
                                    self.deckCardsCollectionView.reloadData()
                                    
                                    self.indexOfSelectedCard = nil
                                }
                            }
                        }
                    }
                }

            case "Сбросить":
                
                
                
                let deckCollectionView = deckCardsCollectionView
                
                let handCollectionView = handCardsCollectionView
                
                if isSelectedCardInHand == false {
                    
                    let cell = deckCollectionView.cellForItem(at: IndexPath(row: index, section: 0) ) as! DeckCollectionViewCell
                    
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                        cell.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                        cell.layer.opacity = 0.2
                        self.designeThenChooseDeckCard(0)
                    } completion: { _ in
                        cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                        deckCollectionView.deleteItems(at: [IndexPath(row: self.indexOfSelectedCard!, section: 0)])
                        var takedCard = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray.remove(at: index)
                        self.qtyOfCardsInDeck = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray.count
                        
                        takedCard.isPressed = false
                        gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].dischardCardArray.append(takedCard)
                        
                        self.cardImageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cover )
                        deckCollectionView.reloadData()
                        self.indexOfSelectedCard = nil
                        
                    }
                } else {
                    
                    let cell = handCollectionView.cellForItem(at: IndexPath(row: index, section: 0) ) as! DeckCollectionViewCell
                    
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                        cell.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                        cell.layer.opacity = 0.2
                        self.designeThenChooseHandCard(0)
                    } completion: { _ in
                        cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                        handCollectionView.deleteItems(at: [IndexPath(row: self.indexOfSelectedCard!, section: 0)])
                        var takedCard = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray.remove(at: index)
                        self.qtyOfCardsInHand = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray.count
                        
                        takedCard.isPressed = false
                        gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].dischardCardArray.append(takedCard)
                        handCollectionView.reloadData()
                        self.cardImageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cover )
                        self.indexOfSelectedCard = nil
                    }
                }
                
                
            case "Взять":
                
                let deckCollectionView = deckCardsCollectionView
                
                let handCollectionView = handCardsCollectionView
                
                let cell = deckCardsCollectionView.cellForItem(at: IndexPath(row: index, section: 0) ) as! DeckCollectionViewCell
             
                if !isSelectedCardInHand {
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            cell.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                            cell.layer.opacity = 0.2
                            self.designeThenChooseDeckCard(0)
                        } completion: { _ in
                            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                            deckCollectionView.deleteItems(at: [IndexPath(row: self.indexOfSelectedCard!, section: 0)])
                            
                            var takedCard = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray.remove(at: index)
                            
                            takedCard.isFlipedOver = true
                            takedCard.isPressed = false
                            takedCard.isPined = false
                            
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray.append(takedCard)
                            
//                            handCollectionView.insertItems(at: [])
                            
                            self.qtyOfCardsInDeck = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray.count
                            self.qtyOfCardsInHand = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].handArray.count
                            
                            deckCollectionView.reloadData()
                            handCollectionView.reloadData()
                            self.indexOfSelectedCard = nil
                        }
                }

//            case "Вернуть"
                
            default:
                break
            }
     
            } else {
                let alert = (UIAlertController(title: "Cначала выберите карту", message: "А затем выполните действие с ней", preferredStyle: .alert))
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        default:
            break
        }

    }
}

extension DeckViewController: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat { return 20 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
        switch collectionView {
        case deckCardsCollectionView:
            let width = (collectionView.bounds.width - inset * 8 ) / 7
            return CGSize(width: width, height: width * 1.3)
        case handCardsCollectionView:
            let width = (collectionView.bounds.width - inset * 4 ) / 3
            return CGSize(width: width, height: width * 1.3)
        case buttomsCollectionView:
            let height = (collectionView.bounds.height - inset * (numbersButtoms + 3) ) / numbersButtoms
            let width = (collectionView.bounds.width - inset * 3)
            return CGSize(width: width, height: height)
        default:
            break
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset*2, left: inset, bottom: inset*2, right: inset)
    }
    
}




