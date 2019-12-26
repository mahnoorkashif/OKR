//
//  Animation8.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 20/12/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class Animation8: UIViewController {

    var timer : Timer?
    var count : Int = 0
    var startPoint : CGPoint?
    
    let path = UIBezierPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPath()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if count == 100 {
            timer?.invalidate()
            timer = nil
            count = 0
        }
        if count % 2 == 0 {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = #imageLiteral(resourceName: "Star")
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .random
            animateViews(animationView: imageView)
            count += 1
        }
        else {
            let animationView = createView(frame: CGRect(x: 0, y: 0, width: 15, height: 15), color: .random, cornerRadius: 7.5)
            animateViews(animationView: animationView)
            count += 1
        }
    }
    
    private func animateViews(animationView: UIView) {
        view.addSubview(animationView)
        addAnimation(animationView)
    }
    
    private func createView(frame: CGRect, color: UIColor, cornerRadius: CGFloat) -> UIView {
        let viewToAnimate = UIView(frame: frame)
        viewToAnimate.backgroundColor = color
        viewToAnimate.layer.cornerRadius = cornerRadius
        return viewToAnimate
    }
    
    private func addPath() {
        startPoint = CGPoint(x: Int.random(in: 0...Int(view.frame.width)), y: Int.random(in: 0...Int(view.frame.height)))
        path.move(to: startPoint ?? CGPoint.zero)
        
        var previousPoint = startPoint
        
        for _ in 0...30 {
            let randomX = [Int.random(in: 0...Int(view.frame.width)), Int.random(in: 0...Int(view.frame.width))]
            let randomY = [Int.random(in: 0...Int(view.frame.height)), Int.random(in: 0...Int(view.frame.height))]
            let point1 = CGPoint(x: randomX[0], y: randomY[0])
            let point2 = CGPoint(x: randomX[1], y: randomY[1])
            path.addCurve(to: previousPoint ?? CGPoint.zero, controlPoint1: point1, controlPoint2: point2)
            previousPoint = point2
        }
    }
    
    private func addAnimation(_ animationView: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 150
        animation.repeatCount = Float.infinity
        animation.path = path.cgPath
        animation.calculationMode = .paced
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.autoreverses = true
        
        animationView.layer.add(animation, forKey: "position")
        
        let layer           = CAShapeLayer()
        layer.path          = path.cgPath
//        layer.strokeColor   = UIColor.black.cgColor
        layer.lineWidth     = 1.0
        layer.fillColor     = nil
        
        self.view.layer.addSublayer(layer)
    }
}

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}
