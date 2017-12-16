//
//  ViewController.swift
//  TheWeatherForecast
//
//  Created by Gerson Costa on 14/12/2017.
//  Copyright © 2017 Gerson Costa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var locationTxtField: UITextField!
    
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTxtField.delegate = self
        
    }

    @IBAction func getWeatherBtn(_ sender: UIButton) {
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + locationTxtField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
            
            let request = NSMutableURLRequest(url: url)
            var webMessage = ""
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if let error = error {
                    print(error)
                } else {
                    
                    if let unwrappedData = data {
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                            
                            if contentArray.count > 1 {
                                stringSeparator = "</span>"
                                let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                
                                if newContentArray.count > 1 {
                                    webMessage = newContentArray[0].replacingOccurrences(of: "&deg;", with: "º")
                                }
                                
                            }
                        }
                    }
                    
                    if webMessage == "" {
                        webMessage = "Unable to get the weather"
                    }
                    DispatchQueue.main.sync {
                        self.message.text = webMessage
                    }
                }
            }
            task.resume()
        } else {
            message.text = "Unable to get the weather"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

