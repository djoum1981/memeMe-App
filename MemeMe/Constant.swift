//
//  K.swift
//  MemeMe
//
//  Created by Julien Laurent on 11/21/20.
//

import Foundation
enum actionPerform: Int {
    case cancel = 0
    case send
}

enum imageSource: Int{
    case camera = 0
    case albumn
}

struct K {
    static  let topTextPlaceHolder = "TOP"
    static let bottomTextPlaceHolder = "BOTTOM"
    static let textFont = "HelveticaNeue-CondensedBlack"
    static let textSize = 40
    
    struct Cell {
        static var collectionCellIdentifier = "memeCollectionCell" 
        static var tableCellIdentifier = "memeTableCell"
        static var tableViewCellNibName = "MemeTableViewCell"
        static var collectionViewCellNibName = "MemeCollectionViewCell"
    }
    
    struct ViewControllerID {
        static var addNewMemeVCID = "MemeMeVCID"
        static var collToNewMemeSeque = "collToNewMeme"
        static var tableToNewMemeSeque = "tableToNewMeme"
    }
}
