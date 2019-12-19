//
//  Animation7.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 19/12/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class Animation7: UIViewController {
    
    let oldColors : [CGColor] = [#colorLiteral(red: 0.9215686275, green: 0.4117647059, blue: 0.3764705882, alpha: 1).cgColor, #colorLiteral(red: 0.9215686275, green: 0.7411764706, blue: 0.3764705882, alpha: 1).cgColor]
    let newColors : [CGColor] = [#colorLiteral(red: 0.3882352941, green: 0.431372549, blue: 0.9019607843, alpha: 1).cgColor, #colorLiteral(red: 0.2588235294, green: 0.8392156863, blue: 0.4156862745, alpha: 1).cgColor]

    override func viewDidLoad() {
        super.viewDidLoad()
       animateBackground()
    }
    
    private func animateBackground() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = oldColors
        animation.toValue = newColors
        animation.duration = 5.0
        animation.autoreverses = true
        animation.fillMode = .forwards
        animation.repeatCount = Float.infinity
        view.layer.add(animation, forKey: "backgroundColor")
    }
}
