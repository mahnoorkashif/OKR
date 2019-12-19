//
//  Animation6.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 19/12/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class Animation6: UIViewController {
    
    var timer : Timer?
    var count : Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        startAnimation()
        count += 1
        if count == 20 {
            timer?.invalidate()
            timer = nil
            count = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func createView(frame: CGRect, color: UIColor) -> UIView {
        let viewToAnimate = UIView(frame: frame)
        viewToAnimate.backgroundColor = color
        viewToAnimate.layer.cornerRadius = viewToAnimate.frame.width/2
        viewToAnimate.layer.borderColor = UIColor.black.cgColor
        viewToAnimate.layer.borderWidth = 1.0
        return viewToAnimate
    }
    
    private func createPositionAnimation(startPoint: CGPoint, endPoint: CGPoint, duration: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = startPoint
        animation.toValue = endPoint
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func createScaleAnimation(startPoint: CGFloat, endPoint: CGFloat, duration: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = startPoint
        animation.toValue = endPoint
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func createRotationAnimation(duration: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = duration
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func createOpacityAnimation(startPoint: CGFloat, endPoint: CGFloat, duration: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = startPoint
        animation.toValue = endPoint
        animation.duration = duration
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func addAnimations(viewToAnimate: UIView, positionAnimation: CABasicAnimation, scaleAnimation: CABasicAnimation, rotationAnimation: CABasicAnimation, opacityAnimation: CABasicAnimation) {
        viewToAnimate.layer.add(positionAnimation, forKey: "position")
        viewToAnimate.layer.add(scaleAnimation , forKey: "transform.scale")
        viewToAnimate.layer.add(rotationAnimation, forKey: "transform.rotation")
//        viewToAnimate.layer.add(opacityAnimation, forKey: "opacity")
    }
    
    private func startAnimation() {
        let centreX = view.center.x
        let centreY = view.center.y
        
        let viewWidth   : CGFloat   = 75
        let viewHeight  : CGFloat   = 75
        
        let leftX    : CGFloat   = 60
        let rightX   : CGFloat   = view.frame.width - 60
        
        let topY = 3.0 * (self.navigationController?.navigationBar.frame.height ?? 100)
        let bottomY = view.frame.height - 60
        
        // starting points
        let view1StartPoint = CGPoint(x: leftX, y: topY)
        let view2StartPoint = CGPoint(x: rightX, y: topY)
        let view3StartPoint = CGPoint(x: leftX, y: bottomY)
        let view4StartPoint = CGPoint(x: rightX, y: bottomY)
        
        // ending point
        let endPoint = CGPoint(x: centreX, y: centreY)
        
        // create views
        let view1 = createView(frame: CGRect(x: view1StartPoint.x, y: endPoint.y, width: viewWidth, height: viewHeight), color: #colorLiteral(red: 0.9215686275, green: 0.4117647059, blue: 0.3764705882, alpha: 1))
        let view2 = createView(frame: CGRect(x: view2StartPoint.x, y: endPoint.y, width: viewWidth, height: viewHeight), color: #colorLiteral(red: 0.9215686275, green: 0.7411764706, blue: 0.3764705882, alpha: 1))
        let view3 = createView(frame: CGRect(x: view3StartPoint.x, y: endPoint.y, width: viewWidth, height: viewHeight), color: #colorLiteral(red: 0.9215686275, green: 0.7411764706, blue: 0.3764705882, alpha: 1))
        let view4 = createView(frame: CGRect(x: view4StartPoint.x, y: endPoint.y, width: viewWidth, height: viewHeight), color: #colorLiteral(red: 0.9215686275, green: 0.4117647059, blue: 0.3764705882, alpha: 1))
        
        // add views
        view.addSubview(view1)
        view.addSubview(view2)
        view.addSubview(view3)
        view.addSubview(view4)
        
        // create animations
        let view1PositionAnimation = createPositionAnimation(startPoint: view1StartPoint, endPoint: endPoint, duration: 6)
        let view2PositionAnimation = createPositionAnimation(startPoint: view2StartPoint, endPoint: endPoint, duration: 6)
        let view3PositionAnimation = createPositionAnimation(startPoint: view3StartPoint, endPoint: endPoint, duration: 6)
        let view4PositionAnimation = createPositionAnimation(startPoint: view4StartPoint, endPoint: endPoint, duration: 6)
        let scaleAnimation = createScaleAnimation(startPoint: 1.0, endPoint: 0.4, duration: 2.0)
        let rotationAnimation = createRotationAnimation(duration: 1.3)
        let opacityAnimation = createOpacityAnimation(startPoint: 1.0, endPoint: 0.7, duration: 1.5)
        
        // add animations
        addAnimations(viewToAnimate: view1, positionAnimation: view1PositionAnimation, scaleAnimation: scaleAnimation, rotationAnimation: rotationAnimation, opacityAnimation: opacityAnimation)
        addAnimations(viewToAnimate: view2, positionAnimation: view2PositionAnimation, scaleAnimation: scaleAnimation, rotationAnimation: rotationAnimation, opacityAnimation: opacityAnimation)
        addAnimations(viewToAnimate: view3, positionAnimation: view3PositionAnimation, scaleAnimation: scaleAnimation, rotationAnimation: rotationAnimation, opacityAnimation: opacityAnimation)
        addAnimations(viewToAnimate: view4, positionAnimation: view4PositionAnimation, scaleAnimation: scaleAnimation, rotationAnimation: rotationAnimation, opacityAnimation: opacityAnimation)
    }
}
