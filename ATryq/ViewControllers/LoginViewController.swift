//
//  LoginViewController.swift
//  ATryq
//
//  Created by Bassem Abbas on 6/11/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import UIKit
import FacebookLogin

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let loginButton = LoginButton(readPermissions: [ .publicProfile,.email ])
        loginButton.center = view.center
        loginButton.delegate = self;
        view.addSubview(loginButton)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController:LoginButtonDelegate{
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
       
        
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("User cancelled login.")
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            print("Logged in!  \(grantedPermissions)  \(declinedPermissions)  \(accessToken)" )
            
            ViewControllers.setClientMainView(application: appDelegate)
            
        }
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
        
    }
}
