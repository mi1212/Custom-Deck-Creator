//
//  GamesViewController.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 29.05.2022.
//

import UIKit

class GamesViewController: UIViewController {

    static var customCornerRadius: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        setupCollection()
        
    }
    
    private var array: [Int] {
        var array = [Int]()
        for element in 0...1 {
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
        collection.allowsSelection = true
        collection.isPrefetchingEnabled = true
        collection.register(GamesCollectionViewCell.self, forCellWithReuseIdentifier: GamesCollectionViewCell.identifire)
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
        GamesViewController.customCornerRadius = (collectionView.bounds.width) / 65
        
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

extension GamesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0...array.count - 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCollectionViewCell.identifire, for: indexPath) as! GamesCollectionViewCell
            cell.setupCell(name: "cover" + String(indexPath.row), width: (collectionView.bounds.width - inset * 5 ) / 4, index: indexPath.row)
        
            setupCornerAndShadowOfCell(collectionView, cell)
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlusCollectionViewCell.identifire, for: indexPath) as! PlusCollectionViewCell
            cell.layer.cornerRadius = (collectionView.bounds.width - inset * 5 ) / 40
            cell.clipsToBounds = true
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == (array.count) {
            let newgameVC = NewCardViewController()
            self.present(newgameVC, animated: true)
        } else {        
            let deckdVC = GameViewController()
            deckdVC.indexGame = String(indexPath.row)
            self.navigationController?.pushViewController(deckdVC, animated: true)
        }   
    }
}

extension GamesViewController: UICollectionViewDelegateFlowLayout {

    private var inset: CGFloat { return 20 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - inset * 5 ) / 4

        return CGSize(width: width, height: width)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
}
