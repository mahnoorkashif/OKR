//
//  Animation10.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 24/12/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class Animation10: UIViewController {
    
    var button: UIButton?
    var animationView: UIView?
    
    var check = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
}

extension Animation10 {
    private func initUI() {
        let diameter: CGFloat = 65.0
        let radius: CGFloat = diameter / 2
        
        let pathX : CGFloat = self.view.center.x - radius
        let pathY : CGFloat = self.view.center.y - radius
        
        let path = UIBezierPath(ovalIn: CGRect(x: pathX, y: pathY, width: diameter, height: diameter))
                
        let layer           = CAShapeLayer()
        layer.path          = path.cgPath
        layer.strokeColor   = UIColor.white.cgColor
        layer.lineWidth     = 6.0
        layer.fillColor     = nil
        
        self.view.layer.addSublayer(layer)
                
        let diff: CGFloat = 10.0 // difference between heights and widths of circles
        let viewDiameter = diameter - diff // diameter for inner circle - red
        
        let viewX = pathX + diff/2
        let viewY = pathY + diff/2
        
        animationView = UIView(frame: CGRect(x: viewX, y: viewY, width: viewDiameter, height: viewDiameter))
        animationView?.backgroundColor = .red
        animationView?.layer.cornerRadius = (animationView?.frame.width ?? 0) / 2
        
        guard let animationView = animationView else { return }
        
        self.view.addSubview(animationView)
        
        let buttonDiff: CGFloat = 30.0
        
        let buttonX = pathX - buttonDiff/2
        let buttonY = pathY - buttonDiff/2
        
        setButton(x: buttonX, y: buttonY, w: diameter + buttonDiff, h: diameter + buttonDiff)
    }
    
    private func setButton(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        button = UIButton(frame: CGRect(x: x, y: y, width: w, height: h))
        button?.backgroundColor = .clear //#colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.3)
        
        guard let button = button else { return }
        
        self.view.addSubview(button)
                
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}

extension Animation10 {
    @objc func buttonAction(sender: UIButton!) {
        let duration = 0.20
        let endpoint: CGFloat = 0.5
        let startPoint: CGFloat = 1.0
        let oldVal = animationView?.layer.cornerRadius ?? 0.0
        let newVal: CGFloat = 5.0
        if check == false {
            let scaleAnimation = createScaleAnimation(startPoint: startPoint, endPoint: endpoint, duration: duration)
            let cornerAnimation = cornerRadiusAnimation(oldValue: oldVal, newValue: newVal, duration: duration)
            animationView?.layer.add(scaleAnimation, forKey: "transform.scale")
            animationView?.layer.add(cornerAnimation, forKey: #keyPath(CALayer.cornerRadius))
            check = true
        } else if check == true {
            let scaleAnimation = createScaleAnimation(startPoint: endpoint, endPoint: startPoint, duration: duration)
            let cornerAnimation = cornerRadiusAnimation(oldValue: newVal, newValue: oldVal, duration: duration)
            animationView?.layer.add(scaleAnimation, forKey: "transform.scale")
            animationView?.layer.add(cornerAnimation, forKey: #keyPath(CALayer.cornerRadius))
            check = false
        }
    }
    
    private func createScaleAnimation(startPoint: CGFloat, endPoint: CGFloat, duration: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = startPoint
        animation.toValue = endPoint
        animation.duration = duration
        animation.fillMode = .forwards
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    private func cornerRadiusAnimation(oldValue: CGFloat, newValue: CGFloat, duration: Double) -> CABasicAnimation {
        let cornerAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        cornerAnimation.fromValue = oldValue
        cornerAnimation.toValue = newValue
        cornerAnimation.duration = duration
        cornerAnimation.fillMode = .forwards
        cornerAnimation.repeatCount = 1
        cornerAnimation.isRemovedOnCompletion = false
        return cornerAnimation
    }
}
