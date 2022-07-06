//
//  Sotry.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
struct Story
{
    var question: String
    var option1: String
    var option2:  String
    var next1: Int
    var next2: Int
    init(title: String, choice1: String, choice1Destination: Int, choice2:  String, choice2Destination: Int)
    {
        question = title
        option1 = choice1
        option2 = choice2
        next1 = choice1Destination
        next2 = choice2Destination
        
    }
}
