//
//  PanDirectionGestureRecognizer.swift
//  GooTaxi
//
//  Created by Bassem on 9/7/16.
//  Copyright © 2017 ADLANC.COM. All rights reserved.
//

import Foundation

import UIKit
import UIKit.UIGestureRecognizerSubclass

enum PanDirection {
    case vertical
    case horizontal
}

class PanDirectionGestureRecognizer: UIPanGestureRecognizer {
    
    let direction : PanDirection
    
    init(direction: PanDirection, target: AnyObject, action: Selector) {
        self.direction = direction
        super.init(target: target, action: action)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if state == .began {
            let velocity = self.velocity(in: self.view!)
            switch direction {
            case .horizontal where fabs(velocity.y) > fabs(velocity.x):
                state = .cancelled
            case .vertical where fabs(velocity.x) > fabs(velocity.y):
                state = .cancelled
            default:
                break
            }
        }
    }
}
