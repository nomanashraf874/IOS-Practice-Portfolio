//
//  ViewController.swift
//  ByteCoin
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {
    

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

}
//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
        
    }
}
//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate{
    func didUpdatePrice(currency: String, coinPrice: Double) {
        DispatchQueue.main.sync {
                self.bitcoinLabel.text="\(coinPrice)"
                self.currencyLabel.text = currency
            }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

