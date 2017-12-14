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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

