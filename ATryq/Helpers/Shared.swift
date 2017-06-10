//
//  Shared.swift
//  GooTaxi
//
//  Created by Bassem on 8/13/16.
//  Copyright © 2017 ADLANC.COM. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
import Localize_Swift
import PKHUD


var AppAccessToken = "";
var AppDefaultsAuthorized  =  UserDefaults(suiteName: "com.ADLANC.EMBassem.ATryq")!;
var AppDefault = UserDefaults.standard;
var appDelegate = UIApplication.shared.delegate as! AppDelegate


class Shared {
   
    
    
    
    class func setImageViewForNavigation(_ imageName:String,nav:UINavigationItem,navigationBar:UINavigationBar) {
        
        
        DispatchQueue.main.async { 
            
            let navImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 40));
            navImage.center = CGPoint(x: navigationBar.frame.size.width / 2.0, y: navigationBar.frame.size.height / 2.0);
            navImage.image = UIImage(named: imageName);
            nav.titleView = navImage;
            
            
        }
        
        
        
    }
    
    class func ChanheActiveTabForTabBar(_ tabBarController:UITabBarController , activeTab:Int){
        
        
        tabBarController.selectedIndex = activeTab;
        
        if (activeTab == 2){
            
            
            (tabBarController.tabBar.items![2]).image = UIImage(named: "Icon Scan")

            
            
        }else {
            
             (tabBarController.tabBar.items![2]).image = UIImage(named: "Icon Home");
            
        }

        
    }

    
    
    
    
    class func Alert (_ title:String,message:String,confirmTitle:String,IsCansle:Bool=false ,sender:UIViewController){
        
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: confirmTitle, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        appDelegate.window?.rootViewController!.present(alertController, animated: true, completion: nil)
        
        
    }
    
    class func borderButton(_ button:UIButton,cornerRadius:Int = 4,borderColor:UIColor = UIColor.white,borderWidth:Float = 1.0)
    {
        button.layer.cornerRadius = CGFloat(cornerRadius);
        button.layer.borderColor = borderColor.cgColor;
        button.layer.borderWidth=CGFloat(borderWidth);
       
        button.layer.masksToBounds = true;
        
    }
    
   
    
    class func adjustButtonDesign(_ button:UIButton,imageName:String?,text:String,borderColor:UIColor)
    {
        //button.layer.cornerRadius = button.layer.frame.size.height/2;
         button.layer.cornerRadius = CGFloat(4);
        button.layer.borderColor = borderColor.cgColor;
        button.layer.borderWidth=3.0;
         if let imageNameTxt = imageName {
//            if imageName.isNotEmpty {
            let spacing:CGFloat = 10;
//            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
//            button.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
            let btnImage = UIImage(named: imageNameTxt);
            button.setImage(btnImage, for: UIControlState());
            button.setTitle(text, for: .normal)
        }
        button.layer.masksToBounds = true;
        
    }
    
    class func adjustTextFieldDesign(_ textField:UITextField!,imageName:String?,placeHolder:String?,placeHolderColor:UIColor?,borderColor: UIColor?,backgroundColor:UIColor?)
    {
        
        var attributes = [String : AnyObject]();
        if let placeHolderText = placeHolder{
            
            if let placecolor = placeHolderColor {
                attributes[NSForegroundColorAttributeName] = placecolor;
            }
            textField.attributedPlaceholder = NSAttributedString(string:placeHolderText,attributes:attributes);

        }
        textField.layer.borderWidth = 1.0;
        textField.layer.cornerRadius = textField.layer.frame.size.height/2;
        textField.layer.borderColor = borderColor?.cgColor;
        textField.layer.backgroundColor = backgroundColor?.cgColor;
        
        if let name = imageName {
            let image = UIImage(named: name);
            let imageView = UIImageView(image: image);
            let scale:CGFloat=2;
            imageView.contentMode = UIViewContentMode.scaleAspectFit;
            imageView.frame = CGRect(x: 0, y: 0, width: (image!.size.width-4.0) * scale, height: (image!.size.height-4.0) * scale);
            //imageView.tintColor = [UIColor colorWithRed:0.0/255.0 green:173.0/255.0 blue:229.0/255.0 alpha:1.0];
            let padding:CGFloat=2;
            let paddingView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: imageView.bounds.size.width + padding, height: imageView.bounds.size.height + 20));
            imageView.center = paddingView.center;
            paddingView.addSubview(imageView);
            textField.rightView = paddingView;
        }
        
        textField.contentVerticalAlignment = .center;
        // textField.rightViewMode = .Always;
        //    textField.textAlignment =NSTextAlignmentRight;
        textField.layer.masksToBounds = true;
    }
    
    class func adjustTextFieldDesignSetting(_ textField:UITextField!,imageName:String?,placeHolder:String?,placeHolderColor:UIColor?,borderColor: UIColor?,backgroundColor:UIColor?)
    {
        
        var attributes = [String : AnyObject]();
        if let placeHolderText = placeHolder{
            
            if let placecolor = placeHolderColor {
                attributes[NSForegroundColorAttributeName] = placecolor;
            }
            textField.attributedPlaceholder = NSAttributedString(string:placeHolderText,attributes:attributes);
            
        }
        textField.layer.borderWidth = 1.0;
        textField.layer.cornerRadius = 4;
        textField.layer.borderColor = borderColor?.cgColor;
        textField.layer.backgroundColor = backgroundColor?.cgColor;
        
        if let name = imageName {
            let image = UIImage(named: name);
            let imageView = UIImageView(image: image);
            let scale:CGFloat=2;
            imageView.contentMode = UIViewContentMode.scaleAspectFit;
            imageView.frame = CGRect(x: 0, y: 0, width: (image!.size.width-4.0) * scale, height: (image!.size.height-4.0) * scale);
            //imageView.tintColor = [UIColor colorWithRed:0.0/255.0 green:173.0/255.0 blue:229.0/255.0 alpha:1.0];
            let padding:CGFloat=2;
            let paddingView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: imageView.bounds.size.width + padding, height: imageView.bounds.size.height + 20));
            imageView.center = paddingView.center;
            paddingView.addSubview(imageView);
            textField.rightView = paddingView;
        }
        
        textField.contentVerticalAlignment = .center;
        // textField.rightViewMode = .Always;
        //    textField.textAlignment =NSTextAlignmentRight;
        textField.layer.masksToBounds = true;
    }
    
    
    class  HUD {
        
        
        class func progressHUD  (_ title:String?,message:String?,hideafter:Int? = nil,userInteraction:Bool = false){
            
            PKHUD.sharedHUD.contentView = PKHUDProgressView(title: title, subtitle: message);
            PKHUD.sharedHUD.show();
            if (hideafter != nil){
                PKHUD.sharedHUD.hide(afterDelay: TimeInterval(hideafter!));
            }
            
                PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = userInteraction;
            
            
        }
        
        class func successHUD  (_ title:String?,message:String?,hideafter:Int? = nil){
            
            PKHUD.sharedHUD.contentView = PKHUDSuccessView(title: title, subtitle: message);
            PKHUD.sharedHUD.show();
            if (hideafter != nil){
             PKHUD.sharedHUD.hide(afterDelay: TimeInterval(hideafter!));
            }
        }
        
        class func ErrorHUD  (_ title:String?,message:String?,hideafter:Int? = nil){
            
            PKHUD.sharedHUD.contentView = PKHUDErrorView(title: title, subtitle: message);
            PKHUD.sharedHUD.show();
            if (hideafter != nil){
                PKHUD.sharedHUD.hide(afterDelay: TimeInterval(hideafter!));
            }
        }
        
        
       
        
        class func hide (_ after:Int? = nil){
            
           
            if (after == nil){
                PKHUD.sharedHUD.hide(true);
            }else {
                PKHUD.sharedHUD.hide(afterDelay: TimeInterval(after!));
            }
        }
        
        
    }
    
    
//    class AlertDialog
//    {
//    
//        class func alertWithDismiss(_ title:String?,message:String?,image:UIImage?,cancelTitleKey:String,cancelCompletion:(() -> Void)? = nil){
//            
//            
//
//            // Create the dialog
////             let popup = PopupDialog
//            let popup = PopupDialog(title: title, message: message, image: image, buttonAlignment: UILayoutConstraintAxis.vertical, transitionStyle: PopupDialogTransitionStyle.bounceUp, gestureDismissal: false, completion: nil)
//            
//            // Create first button
//            let buttonOne = CancelButton(title: cancelTitleKey) {
//                if (cancelCompletion != nil){
//                cancelCompletion!();
//                }
//            }
//            
//            
//           
//            
//            popup.addButtons([buttonOne])
//            
//            
//            UIApplication.present(popup,animated:true);
//       
//           
//        }
//        
//        
////        class func ValidateRequirePassword(title:String?,description:String? ,placeHolder:String?,callback:@escaping ((_ valid:Bool)->()))  {
////            
////            // Create a custom view controller
////            let confirmPasswordPopup = TextFieldDialogViewController(nibName: "TextFieldDialogViewController", bundle: nil)
////           
////                confirmPasswordPopup.titleLabelString = title;
////                confirmPasswordPopup.descriptionLabelString = description;
////                confirmPasswordPopup.textFieldPlaceholderText = placeHolder;
////          
////            // Create the dialog
////            let popup = PopupDialog(viewController: confirmPasswordPopup, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: false);
////
////            let buttonOne = CancelButton(title: "CANCEL") {
////
////            }
////            
////            
////            let buttonTwo = DefaultButton(title: "CONTINUE") {
////  
////                if let savedPassword = AppDefaultsAuth?.string(forKey: AppUserDefaults.savedPassword.rawValue) , let confirmPassword = confirmPasswordPopup.textField.text {
////                    
////                    if (savedPassword == confirmPassword){
////                        callback(true);
////                    }else {
////                      
////                        Shared.AlertDialog.alertWithDismiss("ERROR".localized(), message: "Your passowrd didnot match", image: nil, cancelTitleKey: "CLOSE".localized());
////                    
////                    }
////                }
////            }
////            
////            popup.addButtons([ buttonTwo , buttonOne])
////            
////            
////            UIApplication.present(popup,animated:true);
////            
////            
////        }
////        
//        
//    }
//    
    class Functions {
        
        class func callPhone(_ number: String) ->Bool {
            if let phoneCallURL:URL = URL(string:"tel://\(number)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.openURL(phoneCallURL);
                }
                return true;
            }else {
                
//                Shared.AlertDialog.alertWithDismiss("SORRY".localized() , message: "FAILED_To_CALL".localized(), image: nil, cancelTitleKey: "CANCEL".localized(), cancelCompletion: nil)
                
               
                
                return false;
            }
            
            
        }
        
        class func openUrl(_ stringURL:String?) -> Bool{
            
            
            if let   urlString = stringURL  {
                if let url = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.openURL(url)
                    return true;
                } else {
                    return false;
                }
                }else{
                   return false;
                    
                }
            }else {
                return false;
            }
            
        }
        
       
    }
    
    class Image {
        
        class func scaleImage (_ oldImage:UIImage?,width:Int?) -> UIImage?{
            if let cgImage = oldImage?.cgImage {
            
            let nwidth = width ?? cgImage.width / 2
            let nheight = ( cgImage.height * width! / cgImage.width ) ?? cgImage.height / 2
            let bitsPerComponent = cgImage.bitsPerComponent
            let bytesPerRow = cgImage.bytesPerRow
            let colorSpace = cgImage.colorSpace
            let bitmapInfo = cgImage.bitmapInfo
        
                if let  context = CGContext(data: nil, width: width!, height: nheight, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue) {
            
                context.interpolationQuality = CGInterpolationQuality.medium;
           
                    context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: CGSize(width: CGFloat(nwidth), height: CGFloat(nheight))));
  
            let scaledImage = context.makeImage().flatMap { UIImage(cgImage: $0) }
                    return scaledImage
            }
            }
            
            
            return nil
            
        }
        
    }
    

}
