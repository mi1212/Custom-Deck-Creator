//
//  Games.swift
//  Custom Deck Creator
//
//  Created by Mikhail Chuparnov on 16.07.2022.
//

import Foundation
import UIKit

var gamesArray = [nemesisGame, sherlokPikasso]

// Nemesis

var nemesisGame = Game(id: 0, name: "Nemesis", cover: "Nemesis_cover", decksQty: nemesisGameDeckArray.count, decksArray: nemesisGameDeckArray)

var draftDeck = Deck(id: 0, name: "Драфт персонажей", cover: "Draft_cover", cardsQty: draftCardsArray.count, cardsArray: draftCardsArray)
var contactDeck = Deck(id: 1, name: "Контакт", cover: "Kontakt_cover", cardsQty: contactCardsArray.count, cardsArray: contactCardsArray)

var nemesisGameDeckArray: [Deck] = [draftDeck, contactDeck]

var draftCardsArray: [Card] = [
    Card(id: 0, nameOfImage: "Draft"+"0"),
    Card(id: 1, nameOfImage: "Draft"+"1"),
    Card(id: 2, nameOfImage: "Draft"+"2"),
    Card(id: 3, nameOfImage: "Draft"+"3"),
    Card(id: 4, nameOfImage: "Draft"+"4"),
    Card(id: 5, nameOfImage: "Draft"+"5"),
    Card(id: 6, nameOfImage: "Draft"+"6")
]

var draftCardsHandArray: [Card] = []

var contactCardsArray: [Card] = [
    Card(id: 0, nameOfImage: "Kontakt"+"0"),
    Card(id: 1, nameOfImage: "Kontakt"+"1"),
    Card(id: 2, nameOfImage: "Kontakt"+"2"),
    Card(id: 3, nameOfImage: "Kontakt"+"3"),
    Card(id: 4, nameOfImage: "Kontakt"+"4"),
]

var contactCardsHandArray: [Card] = []

// Another game

var  sherlokPikasso = Game(id: 1, name: "Sherlok&Pikasso", cover: "Sherlok&Pikasso_cover", decksQty: 10, decksArray: [])
