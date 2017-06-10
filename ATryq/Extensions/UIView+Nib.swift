//
//  UIView+Nib.swift
//  GooTaxi
//
//  Created by Bassem on 9/6/16.
//  Copyright © 2017 ADLANC.COM. All rights reserved.
//

import Foundation
import UIKit

// Usage: Subclass your UIView from NibLoadView to automatically load a xib with the same name as your class


public extension NSObject{
    public class var nameOfClass: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var nameOfClass: String{
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}

extension UIView{
    
    
    class func loadFromNibNamed(_ nibNamed: String  , bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    //    var nibName: String {
    //        return String(self.dynamicType)
    //    }
    //    
    //    //    override init(frame: CGRect) {
    //    //        super.init(frame: frame)
    //    //        nibSetup()
    //    //    }
    //    //    
    //    //    required init?(coder aDecoder: NSCoder) {
    //    //        super.init(coder: aDecoder)
    //    //        nibSetup()
    //    //    }
    //    //    
    //    //    private func nibSetup() {
    //    //        backgroundColor = .clearColor()
    //    //        
    //    //        view = loadViewFromNib()
    //    //        view.frame = bounds
    //    //        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    //    //        view.translatesAutoresizingMaskIntoConstraints = true
    //    //        
    //    //        addSubview(view)
    //    //    }
    //    
    //    public func loadViewFromNib() -> UIView  {
    //        let bundle = NSBundle(forClass: self.dynamicType)
    //        let nib = UINib(nibName: nibName, bundle: bundle)
    //        let nibView = nib.instantiateWithOwner(self, options: nil).first as! UIView
    //        return nibView;
    //        
    //    }
    
}


