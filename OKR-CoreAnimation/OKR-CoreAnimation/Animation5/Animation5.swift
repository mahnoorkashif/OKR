//
//  Animation5.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 19/12/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class Animation5: UIViewController {
    
    var check = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func animateView(_ sender: UIButton) {
        if check == false {
            let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
            animation.fillMode = .forwards
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            animation.duration = 5
            animation.fromValue = view.layer.transform
            animation.toValue = CATransform3DMakeRotation(.pi, 0, 0, 1)
            animation.repeatCount = Float.infinity
            animation.autoreverses = true
            view.layer.add(animation, forKey: "rotate")
            sender.setTitle("STOP", for: .normal)
            check = true
        } else if check == true {
            view.layer.removeAllAnimations()
            sender.setTitle("CLICK TO ANIMATE 🤪", for: .normal)
            check = false
        }
    }
}
