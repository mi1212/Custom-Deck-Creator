//
//  GameDeck.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 14.07.2022.
//

import UIKit

struct Game {
    let id: Int                         // номер игры в массиве игр
    let name: String                    // название игры
    let cover: String                   // картинка рубашки
    let decksQty: Int                   // количество колод
    var decksArray: [Deck]              // массив колод в игре
}
