//
//  CoinManager.swift
//  ByteCoin
//
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate{
    func didUpdatePrice(currency: String, coinPrice: Double)
    func didFailWithError(error: Error)
}
struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "56D00AC4-D5C3-494F-A6FB-ACF20206E83B"
    var delegate: CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let coinArray = ["ETH","LTC","XRP","XMR","NEO"]
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error ?? "Error with error")
                    return
                }
                if let safeData = data {
                    let coinPrice = self.parseJSON(safeData)!
                    
                    delegate?.didUpdatePrice(currency: currency, coinPrice: round(coinPrice*100)/100)
                }
            }
            task.resume()
        }
        
    }
    func parseJSON(_ priceData: Data)-> Double?
    {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PriceData.self, from: priceData)
            let value = decodedData.rate
            return value
            
            
        } catch {
            print(error)
            return nil
        }
    }
    
}
