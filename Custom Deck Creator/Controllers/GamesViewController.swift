//
//  GamesViewController.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 29.05.2022.
//

import UIKit

class GamesViewController: UIViewController {

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
        
        collection.backgroundColor = UIColor(named: "light")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.allowsSelection = true
        collection.clipsToBounds = true
        collection.register(GamesCollectionViewCell.self, forCellWithReuseIdentifier: GamesCollectionViewCell.identifire)
        collection.register(PlusCollectionViewCell.self, forCellWithReuseIdentifier: PlusCollectionViewCell.identifire)
        return collection
    }()
    
    static var customCornerRadius: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "light")
        setupCollection()
        setupNavigationBar(title: "Выберите игру")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(title: "Выберите игру")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.title = ""
    }
    
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
        GamesViewController.customCornerRadius = (collectionView.bounds.width) / 60
        
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
        return gamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCollectionViewCell.identifire, for: indexPath) as! GamesCollectionViewCell
        cell.setupCell(indexOfGameImage: indexPath.row)
        
        setupCornerAndShadowOfCell(collectionView, cell)
        return cell
        
//        switch indexPath.row {
//        case 0...array.count - 1:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCollectionViewCell.identifire, for: indexPath) as! GamesCollectionViewCell
//            cell.setupCell(name: "cover" + String(indexPath.row), width: (collectionView.bounds.width - inset * 5 ) / 4, index: indexPath.row)
//
//            setupCornerAndShadowOfCell(collectionView, cell)
//
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlusCollectionViewCell.identifire, for: indexPath) as! PlusCollectionViewCell
//            cell.layer.cornerRadius = (collectionView.bounds.width - inset * 5 ) / 40
//            cell.clipsToBounds = true
//            return cell
//        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! GamesCollectionViewCell
        let deckdVC = GameViewController()
        
        GameViewController.indexOfGame = indexPath.row
        
        UIView.animate(withDuration: 0.08, delay: 0, options: .allowAnimatedContent ) {
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        }
        self.navigationController?.pushViewController(deckdVC, animated: true)
        
        
        
        
        
        
//        if indexPath.row == (array.count) {
//            let newgameVC = NewCardViewController()
//            self.present(newgameVC, animated: true)
//        } else {
//            let deckdVC = GameViewController()
//            deckdVC.indexGame = String(indexPath.row)
//            self.navigationController?.pushViewController(deckdVC, animated: true)
//        }
    }
}

extension GamesViewController: UICollectionViewDelegateFlowLayout {

    private var inset: CGFloat { return 20 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - inset * 5 ) / 4

        return CGSize(width: width, height: width)
        
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

