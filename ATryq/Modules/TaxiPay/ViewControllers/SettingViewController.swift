//
//  SettingViewController.swift
//  TaxiPay
//
//  Created by Macintosh on 5/4/16.
//  Copyright © 2016 EMBassem. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var baseFairTextField: UITextField!
    @IBOutlet weak var HSDFairTextField: UITextField!
    @IBOutlet weak var LSDFairTextField: UITextField!
    @IBOutlet weak var JSDFairTextField: UITextField!
    @IBOutlet weak var stopFairTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBtn.layer.cornerRadius = 2;
        saveBtn.layer.borderWidth = 1;
        saveBtn.layer.borderColor = UIColor.white.cgColor;
        saveBtn.layer.masksToBounds = true;
        
        let Base_Fair =  defaults.double(forKey: "Base_Fair");
        let   HSD_Fair =  defaults.double(forKey: "HSD_Fair");
        let  LSD_Fair =  defaults.double(forKey: "LSD_Fair");
        let   JSD_Fair = defaults.double(forKey: "JSD_Fair");
        let   STOP_Fair = defaults.double(forKey: "STOP_Fair");
        
        baseFairTextField.text = "\(Base_Fair)";
        HSDFairTextField.text = "\(HSD_Fair)";
        LSDFairTextField.text = "\(LSD_Fair)";
        JSDFairTextField.text = "\(JSD_Fair)";
        stopFairTextField.text = "\(STOP_Fair)";
        
        baseFairTextField.delegate = self;
        HSDFairTextField.delegate = self;
        LSDFairTextField.delegate = self;
        JSDFairTextField.delegate = self;
        stopFairTextField.delegate = self;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Save(_ sender:UIButton){
        
        
        defaults.set( Double(baseFairTextField.text!)!, forKey: "Base_Fair");
        defaults.set(Double(HSDFairTextField.text!)!, forKey: "HSD_Fair");
        defaults.set( Double(LSDFairTextField.text!)!, forKey: "LSD_Fair");
        defaults.set(Double(JSDFairTextField.text!)!, forKey: "JSD_Fair");
        defaults.set(Double(stopFairTextField.text!)! , forKey: "STOP_Fair");
        
        
        
        
        
        self.navigationController?.popToRootViewController(animated: true);
        
        
    }
    
    
}

extension SettingViewController: UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder();
        return true
    }
    
}
