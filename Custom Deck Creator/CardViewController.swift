//
//  CardViewController.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 30.05.2022.
//

import UIKit

class CardViewController: UIViewController {

    var indexDeck: String = ""
    
override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(named: "dark 50%")
    self.view.backgroundColor = .white
    setupCollection()
}

private var array: [Int] {
    var array = [Int]()
    for element in 0...6 {
        array.append(element)
    }
    return array
}

private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
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


private func setupCollection() {
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
}

    func setupCornerAndShadowOfCell(_ collectionView: UICollectionView, _ cell: UICollectionViewCell ) {
        cell.contentView.layer.cornerRadius = GamesViewController.customCornerRadius
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 10)
        cell.layer.shadowRadius = GamesViewController.customCornerRadius
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }


}

// MARK: - extention

extension CardViewController: UICollectionViewDataSource {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    array.count + 1
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch indexPath.row {
    case 0...array.count - 1 :
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DecksCollectionViewCell.identifire, for: indexPath) as! DecksCollectionViewCell
        cell.setupCell(name: "card" + indexDeck + String(indexPath.row), index: indexPath.row)
        
        setupCornerAndShadowOfCell(collectionView, cell)

        return cell
    default:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlusCollectionViewCell.identifire, for: indexPath) as! PlusCollectionViewCell
        cell.layer.cornerRadius = (collectionView.bounds.width - inset * 6 ) / 68
        cell.clipsToBounds = true
        return cell
    }
}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Выбрана ячейка: (\(indexPath.section), \(indexPath.row))")
        
        let deckVC = DeckViewController()
        self.navigationController?.pushViewController(deckVC, animated: true)
        
//        if indexPath.row == (array.count) {
//            let newgameVC = NewCardViewController()
//            self.present(newgameVC, animated: true)
//        } else {
//            let cardVC = CardViewController()
//            cardVC.indexDeck = String(indexGame) + String(indexPath.row)
//            print(cardVC.indexDeck)
//            self.navigationController?.pushViewController(cardVC, animated: true)
//        }
    }



}

extension CardViewController: UICollectionViewDelegateFlowLayout {



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - inset * 6 ) / 5
        
        return CGSize(width: width, height: width * 1.3)
        
    }
    
    private var inset: CGFloat { return 20 }
    
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
