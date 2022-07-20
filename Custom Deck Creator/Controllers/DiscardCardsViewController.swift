//
//  DiscardCardsViewController.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 19.07.2022.
//

import UIKit

class DiscardCardsViewController: UIViewController{
    
    var cellShadowOpacity: Float = 0.3
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "light")
        setup()
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        self.view.addSubview(discardCardsCollectionView)
        
        NSLayoutConstraint.activate([
            discardCardsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: inset),
            discardCardsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            discardCardsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            discardCardsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -inset),
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension DiscardCardsViewController: UICollectionViewDataSource {
    
    
    var numbersButtoms: CGFloat { CGFloat(CardButtoms.allCases.count)}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckCollectionViewCell.identifire, for: indexPath) as! DeckCollectionViewCell
        cell.backgroundColor = .black
        
//        cell.setupCell(indexOfCardImage: indexPath.row)
        setupCornerAndShadowOfCell(cell)
        return cell
        
        
    }
}



extension DiscardCardsViewController: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat { return 20 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - inset * 5 ) / 4
        return CGSize(width: width, height: width * 1.3)
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
