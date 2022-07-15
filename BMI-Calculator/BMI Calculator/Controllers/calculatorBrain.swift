//
//  calculatorBrain.swift
//  BMI Calculator
//
//  Created by Noman Ashraf on 7/11/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct calculatorBrain {
    var bmi: BMI?
    mutating func calculateBMI(height: Float,weight: Float){
        let bmiValue = round((weight/(height*height))*10)/10
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat More!!!", color: UIColor.blue)
        }
        else if bmiValue < 24.5
        {
            bmi = BMI(value: bmiValue, advice: "Eat a little More!!", color: UIColor.green)
        }
        else{
            bmi = BMI(value: bmiValue, advice: "Keep going King!", color: UIColor.red)
        }
    }
    func getBMIValue()->Float {
        return bmi?.value ?? 0.0
    }
    func getAdvice()->String {
        return bmi?.advice ?? "ERROR"
    }
    func getColor()->UIColor {
        return bmi?.color ?? UIColor.clear
    }

}
