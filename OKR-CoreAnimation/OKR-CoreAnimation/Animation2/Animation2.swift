//
//  Animation2.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 29/11/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class Animation2: UIViewController {

    @IBOutlet weak var imageView    : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateImageView()
    }
}

extension Animation2 {
    private func animateImageView() {
        let path = UIBezierPath()
        
        let startPoint = CGPoint(x: self.view.center.x - 100, y: self.view.center.y)
        let endPoint = CGPoint(x: self.view.center.x + 100, y: self.view.center.y)
        
        path.move(to: startPoint)
        
        let point1 = CGPoint(x: startPoint.x, y: startPoint.y - 50)
        let point2 = CGPoint(x: endPoint.x, y: endPoint.y + 50)
        
        path.addCurve(to: endPoint, controlPoint1: point1, controlPoint2: point2)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 2
        animation.repeatCount = Float.infinity
        animation.path = path.cgPath
        animation.calculationMode = .paced
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.autoreverses = true
        
        imageView.layer.add(animation, forKey: "position")
        
        let layer          = CAShapeLayer()
        layer.path          = path.cgPath
        layer.strokeColor   = UIColor.white.cgColor
        layer.lineWidth     = 1.0
        layer.fillColor     = nil
        
        imageView.isHidden = false
        self.view.layer.addSublayer(layer)
    }
}
