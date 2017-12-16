//
//  ViewController.swift
//  TheWeatherForecast
//
//  Created by Gerson Costa on 14/12/2017.
//  Copyright © 2017 Gerson Costa. All rights reserved.
//

import UIKit

class ViewController: UIViewController/*, UITextFieldDelegate*/ {

    @IBOutlet weak var locationTxtField: UITextField!
    
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //locationTxtField.delegate = self
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/London/forecasts/latest") {
        
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
                            if contentArray.count > 0 {
                             stringSeparator = "</span>"
                                let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                if newContentArray.count > 0 {
                                    webMessage = newContentArray[0]
                                    print(webMessage)
                                }
                                
                            }
                        }
                    }
                }
            }
            task.resume()
        }

    }

    @IBAction func getWeatherBtn(_ sender: UIButton) {
    }
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    */
}

