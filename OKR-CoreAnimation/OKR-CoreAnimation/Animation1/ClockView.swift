//
//  ClockView.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 29/11/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class ClockView: UIView {
    var timer            = Timer()
    
    let calendar        = Calendar.current
    var currentHour     : Int?
    var currentMinute   : Int?
    var currentSeconds  : Int?
    
    var lastHourVal     = 0.0
    var shadowAngle     : CGFloat = 4.71238898038469
    
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

extension ClockView {
    @objc private func UpdateTimer() {
        setNeedsDisplay()
    }
    
    private func addClockOutline(lineWidth: CGFloat) {
        let outerCircleRadius = halfWidth
        let outerCircleDiameter = (outerCircleRadius) * 2
        
        guard outerCircleDiameter <= Double(width) || outerCircleDiameter <= Double(height) else { return }
        
        let path = UIBezierPath(ovalIn: CGRect(x: halfWidth - outerCircleRadius, y: halfHeight - outerCircleRadius, width: outerCircleDiameter, height: outerCircleDiameter))
        
        path.lineWidth = lineWidth
        
        UIColor.white.setStroke()
        path.stroke()
    }
    
    private func addClockLines(lineLength: Double, lineWidth: CGFloat, numberOfLines: Int, pathColor: UIColor, path: UIBezierPath) {
        let innerCircleRadius = halfWidth - 10.0
        let innerCircleDiameter = innerCircleRadius * 2
        
        let innerRadius: CGFloat = CGFloat(innerCircleRadius - lineLength)
        let outerRadius: CGFloat = CGFloat(innerCircleRadius + lineLength)
        
        guard innerCircleDiameter <= Double(width) || innerCircleDiameter <= Double(height) else { return }
        
        for i in 0..<numberOfLines {
            let angle = CGFloat(i) * CGFloat(2 * Double.pi) / CGFloat(numberOfLines)
            if numberOfLines == 12 && i == 9 {
                shadowAngle = angle
            }
            let inner = CGPoint(x: innerRadius * cos(angle) + CGFloat(halfWidth), y: innerRadius * sin(angle) + CGFloat(halfHeight))
            let outer = CGPoint(x: outerRadius * cos(angle) + CGFloat(halfWidth), y: outerRadius * sin(angle) + CGFloat(halfHeight))
            path.move(to: inner)
            path.addLine(to: outer)
        }
        
        path.lineWidth = lineWidth
        
        pathColor.setStroke()
        path.stroke()
    }
    
    private func addClockHand(at: Double, numberOfLines: Int, pathColor: UIColor, lineWidth: CGFloat, position: Double, handLength: CGFloat, path: UIBezierPath) {
        
        let hourAngle = CGFloat(at - position) * CGFloat(2 * Double.pi) / CGFloat(numberOfLines)
        let center = CGPoint(x: CGFloat(halfWidth), y: CGFloat(halfHeight))
        let point = CGPoint(x: handLength * cos(hourAngle) + CGFloat(halfWidth), y: handLength * sin(hourAngle) + CGFloat(halfHeight))
        path.move(to: center)
        path.addLine(to: point)
        
        path.lineWidth = lineWidth
        
        pathColor.setStroke()
        path.stroke()
    }
    
    private func addShadow(at position: Double, numberOfLines: Int) {
        let path = UIBezierPath()
        
        let shadowRadius: CGFloat = CGFloat(halfWidth)
        
        let secondAngle = CGFloat(position - 15) * CGFloat(2 * Double.pi) / CGFloat(numberOfLines)
        let center = CGPoint(x: CGFloat(halfWidth), y: CGFloat(halfHeight))
        
        path.move(to: center)
        path.addArc(withCenter: center, radius: shadowRadius, startAngle: shadowAngle, endAngle: secondAngle, clockwise: true)
        
        #colorLiteral(red: 0.4901960784, green: 0.7843137255, blue: 0.7647058824, alpha: 0.3).setFill()
        path.fill()
    }
    
    private func drawClock() {
        addClockOutline(lineWidth: 3.0)
        
        addShadow(at: Double(currentSeconds ?? 0), numberOfLines: 60)
        
        //hour lines
        addClockLines(lineLength: 3.0, lineWidth: 3.0, numberOfLines: 12, pathColor: .white, path: UIBezierPath())
        
        //minute lines
        addClockLines(lineLength: 2.0, lineWidth: 1.0, numberOfLines: 60, pathColor: .white, path: UIBezierPath())
        
        //minute hand
        addClockHand(at: Double(currentMinute ?? 0), numberOfLines: 60, pathColor: .white, lineWidth: 1.5, position: 15, handLength: 80.0, path: UIBezierPath())
        
        //hour hand
        addClockHand(at: lastHourVal, numberOfLines: 12, pathColor: #colorLiteral(red: 0.2990502451, green: 0.7843137255, blue: 0.7647058824, alpha: 1), lineWidth: 2.0, position: 3, handLength: 65.0, path: UIBezierPath())
        
        //second hand
        addClockHand(at: Double(currentSeconds ?? 0), numberOfLines: 60, pathColor: .yellow, lineWidth: 1.5, position: 15, handLength: 90.0, path: UIBezierPath())
    }
}

