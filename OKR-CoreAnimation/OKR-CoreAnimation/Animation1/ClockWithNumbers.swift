//
//  ClockWithNumbers.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 29/11/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class ClockWithNumbers: UIView {
    var timer            = Timer()
    
    let numbers         = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2]
    
    let calendar        = Calendar.current
    var currentHour     : Int?
    var currentMinute   : Int?
    var currentSeconds  : Int?
    
    var lastHourVal     = 0.0
    var shadowAngle     : CGFloat = 0.0
    
    var width           : CGFloat = 0.0
    var height          : CGFloat = 0.0
    var halfWidth       : Double  = 0.0
    var halfHeight      : Double  = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        
        width           = self.frame.width
        height          = self.frame.height
        halfWidth       = Double(width/2)
        halfHeight      = Double(height/2)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        currentHour = calendar.component(.hour, from: Date())
        currentMinute = calendar.component(.minute, from: Date())
        currentSeconds = calendar.component(.second, from: Date())
        
        let diff = Double(currentMinute ?? 60) / 60
        lastHourVal = Double(currentHour ?? 0) + diff
        
        drawClock()
    }
}

extension ClockWithNumbers {
    @objc func UpdateTimer() {
        setNeedsDisplay()
    }
    
    func addHourNumbers(numberOfLines: Int) {
        let innerCircleRadius = halfWidth - 15.0
        let innerCircleDiameter = innerCircleRadius * 2
        
        let distance = 3.0
        
        let outerRadius: CGFloat = CGFloat(innerCircleRadius + distance)
        
        guard innerCircleDiameter <= Double(width) || innerCircleDiameter <= Double(height) else { return }
        
        for i in 0..<numberOfLines {
            let angle = CGFloat(i) * CGFloat(2 * Double.pi) / CGFloat(numberOfLines)
            if i == 9 {
                shadowAngle = angle
            }
            let numberPosition = CGPoint(x: outerRadius * cos(angle) + CGFloat(halfWidth), y: outerRadius * sin(angle) + CGFloat(halfHeight))
            addLabel(text: numbers[i], center: numberPosition)
        }
    }
    
    func addClockLines(lineLength: Double, lineWidth: CGFloat, numberOfLines: Int, pathColor: UIColor, path: UIBezierPath) {
        let innerCircleRadius = halfWidth - 13.0
        let innerCircleDiameter = innerCircleRadius * 2
        
        let innerRadius: CGFloat = CGFloat(innerCircleRadius - lineLength)
        let outerRadius: CGFloat = CGFloat(innerCircleRadius + lineLength)
        
        guard innerCircleDiameter <= Double(width) || innerCircleDiameter <= Double(height) else { return }
        
        for i in 0..<numberOfLines {
            if (i % 5) != 0 {
                let angle = CGFloat(i) * CGFloat(2 * Double.pi) / CGFloat(numberOfLines)
                let inner = CGPoint(x: innerRadius * cos(angle) + CGFloat(halfWidth), y: innerRadius * sin(angle) + CGFloat(halfHeight))
                let outer = CGPoint(x: outerRadius * cos(angle) + CGFloat(halfWidth), y: outerRadius * sin(angle) + CGFloat(halfHeight))
                path.move(to: inner)
                path.addLine(to: outer)
            }
        }
        
        path.lineWidth = lineWidth
        
        pathColor.setStroke()
        path.stroke()
    }
    
    func addClockHand(at: Double, numberOfLines: Int, pathColor: UIColor, lineWidth: CGFloat, position: Double, handLength: CGFloat, path: UIBezierPath) {
        let hourAngle = CGFloat(at - position) * CGFloat(2 * Double.pi) / CGFloat(numberOfLines)
        let center = CGPoint(x: CGFloat(halfWidth), y: CGFloat(halfHeight))
        let point = CGPoint(x: handLength * cos(hourAngle) + CGFloat(halfWidth), y: handLength * sin(hourAngle) + CGFloat(halfHeight))
        path.move(to: center)
        path.addLine(to: point)
        
        path.lineWidth = lineWidth
        
        pathColor.setStroke()
        path.stroke()
    }
    
    func addShadow(at position: Double, numberOfLines: Int) {
        let path = UIBezierPath()
        
        let shadowRadius: CGFloat = CGFloat(halfWidth) - 15.0
        
        let secondAngle = CGFloat(position - 15) * CGFloat(2 * Double.pi) / CGFloat(numberOfLines)
        let center = CGPoint(x: CGFloat(halfWidth), y: CGFloat(halfHeight))
        
        path.move(to: center)
        path.addArc(withCenter: center, radius: shadowRadius, startAngle: shadowAngle, endAngle: secondAngle, clockwise: true)
        
        #colorLiteral(red: 1, green: 0.6078431373, blue: 0.5725490196, alpha: 0.3).setFill()
        path.fill()
    }
    
    func addLabel(text: Int, center: CGPoint) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        label.center = center
        label.textAlignment = .center
        label.text = "\(text)"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        self.addSubview(label)
    }
    
    func drawClock() {
        //hour labels
        addHourNumbers(numberOfLines: 12)
        
        // minute lines
        addClockLines(lineLength: 2.0, lineWidth: 1.0, numberOfLines: 60, pathColor: .white, path: UIBezierPath())
        
        addShadow(at: Double(currentSeconds ?? 0), numberOfLines: 60)
        
        //minute hand
        addClockHand(at: Double(currentMinute ?? 0), numberOfLines: 60, pathColor: .white, lineWidth: 1.5, position: 15, handLength: 80.0, path: UIBezierPath())
        
        //hour hand
        addClockHand(at: lastHourVal, numberOfLines: 12, pathColor: #colorLiteral(red: 1, green: 0.5530688317, blue: 0.6159807326, alpha: 1), lineWidth: 2.0, position: 3, handLength: 65.0, path: UIBezierPath())
        
        //second hand
        addClockHand(at: Double(currentSeconds ?? 0), numberOfLines: 60, pathColor: .yellow, lineWidth: 1.5, position: 15, handLength: 90.0, path: UIBezierPath())
    }
} 
