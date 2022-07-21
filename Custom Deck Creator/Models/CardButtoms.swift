//
//  DeckButtoms.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 11.07.2022.
//

import UIKit

enum CardButtoms: String, CaseIterable {
    case take = "Взять"                         // взять карту
    case discard = "Сбросить"                   // сбросить карту
    case flip = "Перевернуть"                   // перевернуть карту
    case fix = "Закрепить"                      // закрепить карту
    case bringBack = "Вернуть"                  // вернуть карту
    case discardToBox = "В коробку"             // сбросить в коробку
    case bringBackToDeck = "Вернуть в колоду"   // переместить карту из сброса в колоду
    case bringBactToHand = "Вернуть в руку"     // переместить карту из сброса в руку
}

let deckButtomsArray = [takeButtom, discardButtom, flipButtom, fixButtom, bringBackButtom]

let deckCardButtomsArray = [takeButtom, discardButtom, flipButtom, fixButtom]

let handCardButtomsArray = [discardButtom, fixButtom, bringBackButtom]

let discardCardButtomsArray = [bringBackToDeckButtom, bringBactToHandButtom, fixButtom, discardToBoxButtom]

struct CardButtom {
    let name: String
    let isActive: Bool = true
    let function: CardButtoms
}

let takeButtom = CardButtom(name: "Взять", function: CardButtoms.take)
let discardButtom = CardButtom(name: "Сбросить", function: CardButtoms.discard)
let flipButtom = CardButtom(name: "Перевернуть", function: CardButtoms.flip)
let fixButtom = CardButtom(name: "Закрепить", function: CardButtoms.fix)
let bringBackButtom = CardButtom(name: "Вернуть", function: CardButtoms.bringBack)
let discardToBoxButtom = CardButtom(name: "В коробку", function: CardButtoms.discardToBox)
let bringBackToDeckButtom = CardButtom(name: "Вернуть в колоду", function: CardButtoms.bringBackToDeck)
let bringBactToHandButtom = CardButtom(name: "Вернуть в руку", function: CardButtoms.bringBactToHand)


