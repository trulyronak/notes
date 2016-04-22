//
//  Essentials.swift
//  Shapes
//
//  Created by Ronak Shah on 4/9/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//
//  While Apple had a good reason for removing this syntax, I am too used to the old syntax. Therefore, I took advantage to the customization feature in Swift to style my coding accordingly

import Foundation

postfix operator ++ {}

postfix func ++ (inout x: Int) -> Int{
    x += 1
    return x
}

postfix operator -- {}

postfix func -- (inout x: Int) -> Int{
    x -= 1
    return x
}