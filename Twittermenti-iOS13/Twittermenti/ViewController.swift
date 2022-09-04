//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import Swifter
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    let tweetCount = 100
    let swifter = Swifter(consumerKey: "xrzJAbIbMrRokpj7h9qXbNOHw", consumerSecret: "8K2DzNnXliDxBtnVbwUgudegtQQVEI8Brb2HLpwP3moMIVhY5D")
    let classifier = twitter2()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func predictPressed(_ sender: Any) {
        fetchTweets()
    }
    func fetchTweets(){
        if let searchText = textField.text{
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended) { results, Metadata in
                //print(results)
                var tweets = [twitter2Input]()
                for i in 0..<self.tweetCount{
                    if let tweet = results[i]["full_text"].string{
                        let newTweet=twitter2Input(text: tweet)
                        tweets.append(newTweet)
                    }
                }
                self.makePredictions(with: tweets)
                
            } failure: { error in
                print("Error in request: \(error)")
            }
        }

    }
    func makePredictions(with tweets: [twitter2Input]){
        do{
            let output = try self.classifier.predictions(inputs: tweets)
            var score = 0
            for out in output{
                let senti = out.label
                if senti == "Pos"{
                    score+=1
                }else if senti == "Neg"{
                    score-=1
                }
            }
            updateUI(with: score)
        } catch{
            print(error)
        }
    }
    func updateUI(with score: Int){
        if score>20 {
            self.sentimentLabel.text="😍"
        } else if score>10 {
            self.sentimentLabel.text="😀"
        } else if score>0 {
            self.sentimentLabel.text="🙂"
        }else if score==0 {
            self.sentimentLabel.text="😐"
        }else if score > -10 {
            self.sentimentLabel.text="😕"
        }else if score > -20 {
            self.sentimentLabel.text="😡"
        } else{
            self.sentimentLabel.text="🤮"
        }
    }
    
}

