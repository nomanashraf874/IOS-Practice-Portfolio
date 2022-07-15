//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Noman Ashraf on 7/10/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var bmiValue: Float?
    var advice: String?
    var color : UIColor?
    
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = "\(bmiValue!)"
        adviceLabel.text = advice
        background.backgroundColor=color

    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
