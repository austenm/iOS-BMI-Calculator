//
//  ViewController.swift
//  BMICalculator
//
//  Created by Austen Mack on 4/16/20.
//  Copyright © 2020 Austen Mack. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    var Results:Model = Model()
    
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var weightText: UITextField!

    @IBOutlet weak var BMIresult: UITextView!
    @IBOutlet weak var riskResult: UITextView!
    
    struct bmiDecoder: Decodable {
        let bmi: Double
        let more: [String]
        let risk: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightText.text = "60"
        weightText.text = "150"
    }
    
    @IBAction func analyzeInput(_ sender: UIButton) {
        //debugPrint(heightText.text)
        let height = heightText.text!
        let weight = weightText.text!

        let urlAsString = "http://webstrar99.fulton.asu.edu/page3/Service1.svc/calculateBMI?height=\(height)&weight=\(weight)"
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            let decoder = JSONDecoder()
            let jsonResult = try! decoder.decode(bmiDecoder.self, from: data!)
            
            //jsonResult used to be bmiDecoder here
            let bmiR = jsonResult.bmi
            let moreR = jsonResult.more
            let riskR = jsonResult.risk
            
            self.Results.addCallResult(b: bmiR, m: moreR, r: riskR)
            
            let bmiRes = "\(bmiR)"
            let riskRes = "\(riskR)"
            
            DispatchQueue.main.async {
                self.BMIresult.text = bmiRes
            }
            
            DispatchQueue.main.async {
                
                if Double("\(bmiRes)")! < 18 {
                    self.riskResult.textColor = UIColor.blue
                }
                else if Double("\(bmiRes)")! >= 18 && Double("\(bmiRes)")! < 25 {
                    self.riskResult.textColor = UIColor.green
                }
                else if Double("\(bmiRes)")! >= 25 && Double("\(bmiRes)")! <= 30 {
                    self.riskResult.textColor = UIColor.purple
                }
                else if Double("\(bmiRes)")! > 30 { self.riskResult.textColor = UIColor.red
                }
                self.riskResult.text = riskRes
            }
            
        })
        
        jsonQuery.resume()
    }
    
    @IBAction func educateMe(_ sender: UIButton) {
        let url = URL(string: Results.Result.more!)
        
        let vc = SFSafariViewController(url: try url!)
        present(vc, animated: true)
    }
}

