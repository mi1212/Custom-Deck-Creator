//
//  Deck.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 16.07.2022.
//

import Foundation

struct Deck {
    let id: Int                         // порядковый номер в массиве колод
    let name: String                    // название
    let cover: String                   // обложка
    let cardsQty: Int                   // количество карт
    var cardsArray: [Card]              // массив карт
    var handArray: [Card] = []          // пустой массив для карт на руке
    
}
