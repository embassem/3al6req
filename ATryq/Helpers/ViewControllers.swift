//
//  ViewControllers.swift
//  GooTaxiClient
//
//  Created by Bassem Abbas on 4/17/17.
//  Copyright © 2017 ADLANC. All rights reserved.
//

import Foundation
import UIKit

class ViewControllers {
    
    
    class func setClientMainView (application:AppDelegate)
    {
        let stb = UIStoryboard(storyboard: .Main);
        let mainViewController = stb.instantiateInitialViewController()!
       
        application.window?.rootViewController = mainViewController
        application.window?.makeKeyAndVisible()
        

    }
    
    
    class func SetClientLoginView(application:AppDelegate){
  
            let stb = UIStoryboard(storyboard: .Main)
        let loginNav = stb.instantiateViewController(withIdentifier: "LoginViewController");
        
            application.window!.rootViewController = loginNav;
            application.window?.makeKeyAndVisible();
            
        

    }
    
    
    
    
    
    
    
    
    
}
