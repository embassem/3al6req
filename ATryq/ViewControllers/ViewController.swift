//
//  ViewController.swift
//  AalTarek
//
//  Created by Bassem Abbas on 6/5/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import UIKit

class AppHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func lunchTaxipayServices(_ sender: Any) {
        let stb = UIStoryboard(storyboard: .TaxiPay);
        let vc = stb.instantiateViewController(withIdentifier: "TaxiPayMainViewController");
        self.navigationController?.pushViewController(vc, animated: true);
    }
}

