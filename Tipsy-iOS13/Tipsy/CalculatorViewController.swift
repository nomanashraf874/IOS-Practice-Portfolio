//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    var split: Int = 2
    var percent: Double = 0.10
    var totalA: Double = 0.0
    @IBOutlet weak var splitNumber: UILabel!
    @IBOutlet weak var textFeild: UITextField!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var twentyButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func splitAction(_ sender: UIStepper) {
        splitNumber.text = String(Int(sender.value))
        split = Int(sender.value)
    }
    @IBAction func percentChanged(_ sender: UIButton) {
        if sender.titleLabel?.text == "20%"
        {
            twentyButton.isSelected=true
            zeroButton.isSelected=false
            tenButton.isSelected=false
            percent = 0.20
        }
        else if sender.titleLabel?.text == "10%"
        {
            twentyButton.isSelected=false
            zeroButton.isSelected=false
            tenButton.isSelected=true
            percent=0.10
        }
        else {
            twentyButton.isSelected=false
            zeroButton.isSelected=true
            tenButton.isSelected=false
            percent = 0.00
        }
    }
    @IBAction func calculate(_ sender: UIButton) {
        let bill = Double(textFeild.text ?? "0.0")
        let tip = (bill ?? 0.0) * percent
        totalA = round((((bill ?? 0.0)+tip)/Double(split))*100)/100.0
        print(totalA)
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.totalBill = totalA
            destinationVC.scriptText = "Split between \(split) people, with \(Int(percent*100))% tip."
        }
    }
    
    

}

