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
    
    private func createView(frame: CGRect, color: UIColor, cornerRadius: CGFloat) -> UIView {
        let viewToAnimate = UIView(frame: frame)
        viewToAnimate.backgroundColor = color
        viewToAnimate.layer.cornerRadius = cornerRadius
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
    
    private func addAnimations(viewToAnimate: UIView, positionAnimation: CABasicAnimation?, scaleAnimation: CABasicAnimation?, rotationAnimation: CABasicAnimation?, opacityAnimation: CABasicAnimation?) {
        if let positionAnimation = positionAnimation {
            viewToAnimate.layer.add(positionAnimation, forKey: "position")
        }
        if let scaleAnimation = scaleAnimation {
            viewToAnimate.layer.add(scaleAnimation , forKey: "transform.scale")
        }
        if let rotationAnimation = rotationAnimation {
            viewToAnimate.layer.add(rotationAnimation, forKey: "transform.rotation")
        }
        if let opacityAnimation = opacityAnimation {
            viewToAnimate.layer.add(opacityAnimation, forKey: "opacity")
        }
    }
    
    private func startAnimation() {
        let centreX = view.center.x
        let centreY = view.center.y
        
        let cornerViewsWidth   : CGFloat   = 60
        let cornerViewsHeight  : CGFloat   = 60
        
        let centreViewsWidth   : CGFloat   = 40
        let centreViewsHeight  : CGFloat   = 40
        
        let leftX    : CGFloat   = 60
        let rightX   : CGFloat   = view.frame.width - leftX
        
        let topY = 3.0 * (self.navigationController?.navigationBar.frame.height ?? 100)
        let bottomY = view.frame.height - 60
        
        // starting points
        let points = [CGPoint(x: leftX, y: topY), CGPoint(x: rightX, y: topY),
                     CGPoint(x: rightX, y: bottomY), CGPoint(x: leftX, y: bottomY),
                     CGPoint(x: centreX, y: topY), CGPoint(x: leftX, y: centreY),
                     CGPoint(x: centreX, y: bottomY), CGPoint(x: rightX, y: centreY)]
        
        // ending point
        let endPoint = CGPoint(x: centreX, y: centreY)
        
        // corner radius
        let cornerRadius = centreViewsWidth/2
        
        // create and add subviews
        var views = [UIView]()
    
        for i in 0...(points.count - 1) {
            var color = UIColor.clear
            var animationView = UIView()
            if i < 4 {
                if i % 2 == 0 {
                    color = #colorLiteral(red: 0.9215686275, green: 0.4117647059, blue: 0.3764705882, alpha: 1)
                } else {
                    color = #colorLiteral(red: 0.9215686275, green: 0.7411764706, blue: 0.3764705882, alpha: 1)
                }
                animationView = createView(frame: CGRect(x: points[i].x, y: points[i].y, width: cornerViewsWidth, height: cornerViewsHeight), color: color, cornerRadius: 0)
            } else {
                if i % 2 == 0 {
                    color = #colorLiteral(red: 0.3882352941, green: 0.431372549, blue: 0.9019607843, alpha: 1)
                } else {
                    color = #colorLiteral(red: 0.2588235294, green: 0.8392156863, blue: 0.4156862745, alpha: 1)
                }
                animationView = createView(frame: CGRect(x: points[i].x, y: points[i].y, width: centreViewsWidth, height: centreViewsHeight), color: color, cornerRadius: cornerRadius)
            }
            view.addSubview(animationView)
            views.append(animationView)
        }

        // create position, scale, rotation and opacity animations
        var postionAnimations = [CABasicAnimation]()
        for j in 0...(views.count - 1) {
            postionAnimations.append(createPositionAnimation(startPoint: points[j], endPoint: endPoint, duration: 6))
        }
        let scaleAnimation = createScaleAnimation(startPoint: 1.0, endPoint: 0.4, duration: 2.0)
        let rotationAnimation = createRotationAnimation(duration: 1.3)
//        let opacityAnimation = createOpacityAnimation(startPoint: 1.0, endPoint: 0.7, duration: 1.5)
        
        // add animations
        for k in 0...7 {
            if k < 4 {
            addAnimations(viewToAnimate: views[k], positionAnimation: postionAnimations[k], scaleAnimation: scaleAnimation, rotationAnimation: rotationAnimation, opacityAnimation: nil)
            } else {
                addAnimations(viewToAnimate: views[k], positionAnimation: postionAnimations[k], scaleAnimation: scaleAnimation, rotationAnimation: nil, opacityAnimation: nil)
            }
        }
    }
}
