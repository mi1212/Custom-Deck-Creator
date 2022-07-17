//
//  Card.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 14.07.2022.
//

import UIKit

struct Card {
    let id: Int                         // порядковый номер в массиве карт
    let nameOfImage: String             // имя картинки
    var isPressed: Bool = false         // карта выбрана(т.е. нажата)
    var isFlipedOver: Bool = false      // карта перевернута
    var isPined: Bool = true            // карта зафиксирована
}
