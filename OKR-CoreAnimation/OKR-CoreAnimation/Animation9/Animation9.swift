//
//  Animation9.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 23/12/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class Animation9: UIViewController {
    var timer : Timer?
    var index : Int = 0
    var count : Int = 0
    
    var paths : [UIBezierPath] = []
    var points : [CGPoint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        createPaths()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
}

extension Animation9 {
    private func createPaths() {
        let diff = Int((self.view.frame.width) / 20)
        
        var i = diff
        let width = Int(self.view.frame.width)
        let height = Int(view.frame.height)
        let y = Int(self.navigationController?.navigationBar.frame.height ?? 0)
        
        while i < width {
            let path = UIBezierPath()
            let startPoint = CGPoint(x: i, y: y)
            path.move(to: startPoint)
            path.addLine(to: CGPoint(x: i, y: height))
                        
            let layer          = CAShapeLayer()
            layer.path          = path.cgPath
//            layer.strokeColor   = UIColor.black.cgColor
            layer.lineWidth     = 1.0
            layer.fillColor     = nil
            
            self.view.layer.addSublayer(layer)
            
            i += diff
            
            paths.append(path)
            points.append(startPoint)
        }
    }
    
    private func createStar() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: points[index].x, y: points[index].y, width: 20, height: 20))
        imageView.image = #imageLiteral(resourceName: "Star")
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .random
        return imageView
    }
    
    private func createPositionAnimation(path: UIBezierPath, starView: UIView, duration: Double) {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = duration
        animation.path = path.cgPath
        animation.repeatCount = Float.infinity
        animation.calculationMode = .paced
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        starView.layer.add(animation, forKey: "position")
        
        let layer          = CAShapeLayer()
        layer.path          = path.cgPath
        
        self.view.layer.addSublayer(layer)
}
    
    @objc private func updateTimer() {
        if count == 200 {
            timer?.invalidate()
            timer = nil
            count = 0
        } else {
            index = Int.random(in: 0...(paths.count - 1))
            let starView = createStar()
            self.view.addSubview(starView)
            createPositionAnimation(path: paths[index], starView: starView, duration: 5)
            count += 1
        }
    }
}
