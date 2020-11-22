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
}
