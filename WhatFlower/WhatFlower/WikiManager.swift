//
//  WikiManager.swift
//  WhatFlower
//
//  Created by Noman Ashraf on 8/20/22.
//
/*
 func performRequest(with urlString: String){
     //Create a URL
     if let url = URL(string: urlString){
         //create URL session
         let session = URLSession(configuration: .default)
         //Give session a task
         let task = session.dataTask(with: url) { data, response, error in
             if error != nil {
                 self.delegate?.didFailWithError(error: error!)
                 return
             }
             if let safeData = data {
                 if let weather = self.parseJSON(safeData){
                     delegate?.didUpdateWeather(self, weather:weather)
                 }
             }
         }
         //Start task
         task.resume()
         
     }
 let decoder = JSONDecoder()
 do {
     let decodedData = try decoder.decode(SafeData.self, from: safeData)
     
     
     
 } catch {
     fatalError()
 }
 protocol WikiManagerDelegate{
     func didUpdateWiki(info: String)
     func didFailWithError(error: Error)
 }
 }
 */
import Foundation
protocol WikiManagerDelegate{
    func didUpdateWiki(info: String, url: String)
    func didFailWithError(error: Error)
}
class WikiManager{
    var delegate: WikiManagerDelegate?
    func fetchInfo(title:String){
        let urlString = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts%7Cpageimages&pithumbsize=500&exintro=&explaintext=&titles=\(title)&indexpageids&redirects=1"
        let newString = urlString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        performRequest(urlString: newString)
    }
    func performRequest(urlString: String) {
            if let url = URL(string: urlString) {
                let session = URLSession(configuration: .default)
                
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        self.delegate?.didFailWithError(error: error!)
                    }
                    
                    if let safeData = data {
                        self.parseJSON(safeData)
                        
                    }
                }
                task.resume()
            }
        }
    func parseJSON(_ wikiData: Data)
    {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WikiData.self, from: wikiData).query.pages
            if let pageKey = decodedData.first?.key { //changing dictionary key captured here
                let results = decodedData[pageKey]! // Dictionary that the changing key refers to
                self.delegate?.didUpdateWiki(info: results.extract, url: results.thumbnail.source)
                print(results.extract)
            }
        } catch {
            self.delegate?.didFailWithError(error: error)
        }
        
    }
}
