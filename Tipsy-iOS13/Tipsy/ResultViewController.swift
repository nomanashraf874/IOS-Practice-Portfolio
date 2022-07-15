//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Noman Ashraf on 7/11/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var totalBill: Double?
    var scriptText: String?
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var script: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        total.text = "\(totalBill ?? 0.0)"
        script.text = scriptText
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recalculate(_ sender: Any) {
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
