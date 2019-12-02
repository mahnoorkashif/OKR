//
//  Animation4.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 02/12/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class Animation4: UIViewController {
    
    @IBOutlet weak var button : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let old = button.layer.cornerRadius
        let new = button.frame.width
        
        let cornerAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        cornerAnimation.fromValue = old
        cornerAnimation.toValue = new
        cornerAnimation.duration = 3.0
        cornerAnimation.autoreverses = true
        cornerAnimation.fillMode = .forwards
        cornerAnimation.repeatCount = Float.infinity
        
        button.layer.cornerRadius = new
        button.layer.add(cornerAnimation, forKey: #keyPath(CALayer.cornerRadius))
    }
}
