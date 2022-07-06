//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    @IBOutlet weak var choice2: UIButton!
    var quizBrain = QuizBrain()
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let buttonName = sender.currentTitle!
        let check=quizBrain.checkAnswer(buttonName)
        if check
        {
            sender.backgroundColor = UIColor.green
            
        }
        else{
            sender.backgroundColor = UIColor.red
        }
        quizBrain.nextQuestion()
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        trueButton.setTitle(quizBrain.getChoices()[0], for: .normal)
        choice2.setTitle(quizBrain.getChoices()[1], for: .normal)
        falseButton.setTitle(quizBrain.getChoices()[2], for: .normal)
        trueButton.backgroundColor = UIColor.clear
        choice2.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        progressBar.progress = quizBrain.getProgress()
        score.text = "Score: \(quizBrain.getScore())"
    }

}

