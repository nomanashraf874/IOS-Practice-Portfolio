//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Noman Ashraf on 6/30/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct Question{
    var question: String
    var ansChoice: [String]
    var ans:  String
    init(q: String, a: [String], correctAnswer:  String)
    {
        question = q
        ansChoice = a
        ans = correctAnswer
    }
}
