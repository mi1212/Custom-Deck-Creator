//
//  DeckViewController.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 31.05.2022.
//

import UIKit

class DeckViewController: UIViewController {
    
    static var indexOfDeck: Int?            // индекс колоды
    
    // свойство чтобы понимать что карта выбрана(нажата) в руке(true) или в колоде(false)
    var isSelectedCardInHand: Bool = false
    // индекс выбранной карты
    var indexOfSelectedCard: Int?
    
    var qtyOfCardsInDeck = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsQty
    
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
        self.view.addSubview(deckCardsCollectionView)
        self.view.addSubview(imageView)
        imageView.addSubview(cardImageView)
        self.view.addSubview(buttomsCollectionView)
        self.view.addSubview(handCardsCollectionView)
        
        cardImageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cover)
        
        let viewsArray = [deckCardsCollectionView, imageView, buttomsCollectionView, handCardsCollectionView, cardImageView]
        
        let _: [()] = viewsArray.map{$0.layer.cornerRadius = GamesViewController.customCornerRadius}
        
        
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
    
    func takeCard(collectionView: UICollectionView,indexPath: IndexPath) {
        
        switch indexPath {
        case nil:
            break
        default:
            if collectionView == deckCardsCollectionView {
                collectionView.deleteItems(at: [indexPath])
                deckCardsCollectionView.reloadData()
                handCardsCollectionView.reloadData()

            } else if collectionView == handCardsCollectionView {
                collectionView.deleteItems(at: [indexPath])
                deckCardsCollectionView.reloadData()
                handCardsCollectionView.reloadData()
            }
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
            return 0
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
            
            cell.setupCell(indexOfCardImage: indexPath.row)
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
            
            indexOfSelectedCard = indexPath.row
            
            if let cell = collectionView.cellForItem(at: indexPath) as? DeckCollectionViewCell {
                //переключение состояния выбора ячейки
                switch gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexOfSelectedCard!].isPressed {
                case false:
                    cell.layer.opacity = 0.8
                    cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                case true:
                    indexOfSelectedCard = nil
                }
                
            }
        case handCardsCollectionView:
            
            indexOfSelectedCard = indexPath.row
            
            if let cell = collectionView.cellForItem(at: indexPath) as? DeckCollectionViewCell {
                //переключение состояния выбора ячейки
                switch gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexPath.row].isPressed {
                case true:
                    cell.layer.opacity = 1
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexPath.row].isPressed.toggle()
                case false:
                    cell.layer.opacity = 0.8
                    cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexPath.row].isPressed.toggle()
                }
            }
        case buttomsCollectionView:
            let cell = buttomsCollectionView.cellForItem(at: indexPath) as! ButtomCollectionViewCell
            UIView.animate(withDuration: 0.08, delay: 0, options: .autoreverse) {
                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } completion: { _ in
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            }

            switch cell.titleView.text {
            case "Закрепить":
                
                let cell = deckCardsCollectionView.cellForItem(at: IndexPath(row: indexOfSelectedCard!, section: 0) ) as! DeckCollectionViewCell
                
                if isSelectedCardInHand == false {
                    
                    switch gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexOfSelectedCard!].isPined {
                    case false:
                        
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            cell.holdImageView.layer.opacity = 1
                            cell.holdImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                            cell.layer.opacity = 1
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[self.indexOfSelectedCard!].isPined.toggle()
                        } completion: { _ in
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                                cell.holdImageView.layer.opacity = 0.7
                                cell.holdImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                cell.holdImageView.transform = CGAffineTransform(rotationAngle: 45)
                            } completion: { _ in
                                self.deckCardsCollectionView.reloadData()
                            }
                        }
                        
                    case true:
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            cell.holdImageView.layer.opacity = 0.2
                            cell.holdImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                            cell.layer.opacity = 1
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[self.indexOfSelectedCard!].isPined.toggle()
                        } completion: { _ in
                            self.deckCardsCollectionView.reloadData()
                        }
                        
                    }
                    
                    

                } else {
                    handCardsCollectionView.reloadData()
                }
            case "Перевернуть":
//                print("перевернуть")
                if isSelectedCardInHand == false {
                    
                    
                    let cell = deckCardsCollectionView.cellForItem(at: IndexPath(row: indexOfSelectedCard!, section: 0) ) as! DeckCollectionViewCell
                    
                    switch gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[indexOfSelectedCard!].isFlipedOver {
                    case false:
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.9)
                        } completion: { _ in
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                                cell.imageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[self.indexOfSelectedCard!].nameOfImage)
                                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                            } completion: { _ in
                                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    cell.layer.opacity = 1
                                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[self.indexOfSelectedCard!].isFlipedOver.toggle()
                                } completion: { _ in
                                    self.deckCardsCollectionView.reloadData()
                                }
                            }
                        }
                    case true:
                        
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.9)
                        } completion: { _ in
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                                cell.imageView.image = UIImage(named: gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cover)
                                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                            } completion: { _ in
                                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    cell.layer.opacity = 1
                                    gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray[self.indexOfSelectedCard!].isFlipedOver.toggle()
                                } completion: { _ in
                                    self.deckCardsCollectionView.reloadData()
                                }
                            }
                        }
                    }
                }
                
//            case "Взять" // взять карту
            case "Сбросить":
                
                let cell = deckCardsCollectionView.cellForItem(at: IndexPath(row: indexOfSelectedCard!, section: 0) ) as! DeckCollectionViewCell
                
                let collectionView = deckCardsCollectionView
                

                if isSelectedCardInHand == false {
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            cell.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                            cell.layer.opacity = 0.2
                        } completion: { _ in
                            collectionView.deleteItems(at: [IndexPath(row: self.indexOfSelectedCard!, section: 0)])
                            gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray.remove(at: self.indexOfSelectedCard!)
                            self.qtyOfCardsInDeck = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].cardsArray.count
                            collectionView.reloadData()
                        }
                } else {
                    handCardsCollectionView.reloadData()
                }
//            case "Перевернуть"// перевернуть карту

//            case "Вернуть"
                
            default:
                break
            }

        default:
            break
        }

    }
    
//    func collectionView(_ collectionView: UICollectionView, selectionFollowsFocusForItemAt indexPath: IndexPath) -> Bool {
//        true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
//        true
//    }

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




