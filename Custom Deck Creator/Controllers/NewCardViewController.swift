//
//  NewCardViewController.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 30.05.2022.
//

import UIKit

class NewCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "light")
        setup()
    }
    
    private var lableView: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.text = "NewCardViewController"
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private func setup() {
        view.addSubview(lableView)
        
        NSLayoutConstraint.activate([
            lableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lableView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    


}
