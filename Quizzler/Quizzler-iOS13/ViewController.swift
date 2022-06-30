//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    let quiz = [["Are you ready?","True"],["Hello?","False"],["Really?","True"],["U sure?","True"],["Hmmm?","False"]]
    var num = 0
    struct Questions{
        let question = "Question?"
        let ans = "Answer."
        
    }
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let buttonName = sender.currentTitle
        if(buttonName == quiz[num][1])
        {
            print("Right!")
        }
        else {
            print("Wrong!")
        }
        if(num<quiz.count-1)
        {
            num = num+1;
        }
        else{
            num = 0
        }
        updateUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    func updateUI() {
        questionLabel.text = quiz[num][0]
    }

}

