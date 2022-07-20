//
//  DiscardCardsViewController.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 19.07.2022.
//

import UIKit

class DiscardCardsViewController: UIViewController{
    
    var cellShadowOpacity: Float = 0.6
    
    let qtyOfCardsInDischard = gamesArray[GameViewController.indexOfGame!].decksArray[DeckViewController.indexOfDeck!].dischardCardArray.count
    
    // вью сброшенных карт
    private lazy var discardCardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "dark 50%")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = false
        collection.layer.cornerRadius = GamesViewController.customCornerRadius
        collection.register(DeckCollectionViewCell.self, forCellWithReuseIdentifier: DeckCollectionViewCell.identifire)
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
        
        collection.layer.cornerRadius = GamesViewController.customCornerRadius
        collection.register(ButtomCollectionViewCell.self, forCellWithReuseIdentifier: ButtomCollectionViewCell.identifire)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "light")
        setup()

    }
    
    private func setup() {
        self.view.addSubview(discardCardsCollectionView)
        self.view.addSubview(buttomsCollectionView)
        
        NSLayoutConstraint.activate([
            discardCardsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: inset),
            discardCardsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            discardCardsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            discardCardsCollectionView.bottomAnchor.constraint(equalTo: buttomsCollectionView.topAnchor, constant: -inset),
        ])
        
        NSLayoutConstraint.activate([
            buttomsCollectionView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/9),
            buttomsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -inset),
            buttomsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            buttomsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
        ])
    }
    
    func setupCornerAndShadowOfCell(_ cell: UICollectionViewCell ) {
        cell.contentView.layer.masksToBounds = true
        
        cell.contentView.layer.cornerRadius = GamesViewController.customCornerRadius
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = GamesViewController.customCornerRadius
        cell.layer.shadowOpacity = cellShadowOpacity
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
    }
    

     // MARK: - Navigation


    
}
    // MARK: - DataSource, Delegate
extension DiscardCardsViewController: UICollectionViewDataSource {
    
    
    var numbersButtoms: CGFloat { CGFloat(CardButtoms.allCases.count)}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case discardCardsCollectionView:
            return qtyOfCardsInDischard
//            return 6
        case buttomsCollectionView:
            return CardButtoms.allCases.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
 
        
        switch collectionView {
        case discardCardsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckCollectionViewCell.identifire, for: indexPath) as! DeckCollectionViewCell
            cell.setupDiscardCardCell(indexOfCardImage: indexPath.row)
            setupCornerAndShadowOfCell(cell)
            return cell
            
        case buttomsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtomCollectionViewCell.identifire, for: indexPath) as! ButtomCollectionViewCell
        
            setupCornerAndShadowOfCell(cell)
            
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

}

extension DiscardCardsViewController: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat { return 20 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
//        CGSize(width: 100, height: 30)
        print("number of buttoms = \(numbersButtoms)")
        switch collectionView {
        case discardCardsCollectionView:
            let width = (collectionView.bounds.width - inset * 5 ) / 4
            return CGSize(width: width, height: width * 1.3)
        case buttomsCollectionView:
            let height = (buttomsCollectionView.bounds.height - inset * 2)
            let width = (buttomsCollectionView.bounds.width - inset * (numbersButtoms + 1) ) / numbersButtoms
            return CGSize(width: width, height: height)
//            return CGSize(width: 100, height: 100)
        default:
            return CGSize(width: 100, height: 100)
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
