//
//  DeckButtoms.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 11.07.2022.
//

import UIKit

enum CardButtoms: String, CaseIterable {
    case take = "Взять в руку"                              // взять карту
    case discard = "Сбросить в биту"                        // сбросить карту
    case flip = "Перевернуть"                               // перевернуть карту
    case fix = "Закрепить"                                  // закрепить карту
    case bringBack = "Скинуть в колоду"                     // вернуть карту
    case discardToBox = "В коробку"                         // сбросить в коробку
    case bringBackToDeck = "Вернуть в колоду"               // переместить карту из сброса в колоду
    case bringBactToHand = "Вернуть в руку"                 // переместить карту из сброса в руку
}

let deckButtomsArray = [bringBackButtom, discardButtom, fixButtom, flipButtom, takeButtom]

let deckCardButtomsArray = [takeButtom, discardButtom, flipButtom, fixButtom]

let handCardButtomsArray = [discardButtom, fixButtom, bringBackButtom]

let discardCardButtomsArray = [bringBackToDeckButtom, bringBactToHandButtom, fixButtom, discardToBoxButtom]

struct CardButtom {
    let name: String
    let isActive: Bool = true
    let function: CardButtoms
}

let takeButtom = CardButtom(name: CardButtoms.take.rawValue ,  function: CardButtoms.take)
let discardButtom = CardButtom(name: CardButtoms.discard.rawValue , function: CardButtoms.discard)
let flipButtom = CardButtom(name: CardButtoms.flip.rawValue, function: CardButtoms.flip)
let fixButtom = CardButtom(name: CardButtoms.fix.rawValue, function: CardButtoms.fix)
let bringBackButtom = CardButtom(name: CardButtoms.bringBack.rawValue, function: CardButtoms.bringBack)
let discardToBoxButtom = CardButtom(name: CardButtoms.discardToBox.rawValue, function: CardButtoms.discardToBox)
let bringBackToDeckButtom = CardButtom(name: CardButtoms.bringBackToDeck.rawValue, function: CardButtoms.bringBackToDeck)
let bringBactToHandButtom = CardButtom(name: CardButtoms.bringBactToHand.rawValue, function: CardButtoms.bringBactToHand)


