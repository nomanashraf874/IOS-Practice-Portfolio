//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    var calculatorObject = calculatorBrain()
    
    @IBOutlet weak var heightS: UISlider!
    
    @IBOutlet weak var weightS: UISlider!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBAction func heightSlider(_ sender: UISlider) {
        let height=round(sender.value * 100) / 100.0
        heightLabel.text = "\(height) m"
    }
    
    @IBAction func weightSlider(_ sender: UISlider) {
        let weight=Int(round(sender.value))
        weightLabel.text = "\(weight) kg"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func calculateButton(_ sender: UIButton) {
        let height = heightS.value
        let weight = weightS.value
        calculatorObject.calculateBMI(height: height ,weight: weight)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorObject.getBMIValue()
            destinationVC.advice = calculatorObject.getAdvice()
            destinationVC.color = calculatorObject.getColor()
        }
    }
    

}

