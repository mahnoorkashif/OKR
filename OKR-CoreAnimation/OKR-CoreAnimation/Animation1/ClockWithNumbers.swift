//
//  ClockWithNumbers.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 29/11/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class ClockWithNumbers: UIView {
    let hours            = 12
    let minutes          = 60
    let seconds          = 60
    var timer            = Timer()
    
    let numbers         = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2]
    
    let calendar        = Calendar.current
    var currentHour     : Int?
    var currentMinute   : Int?
    var currentSeconds  : Int?
    
    var lastHourVal     = 0.0
    
    var shadowAngle     : CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
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
        addHourLines()
        addMinuteLines()
        addShadow(at: Double(currentSeconds ?? 0))
        addMinuteHand(at: Double(currentMinute ?? 0))
        addHourHand(at: lastHourVal)
        addSecondHand(at: Double(currentSeconds ?? 0))
    }
}

extension ClockWithNumbers {
    @objc func UpdateTimer() {
        setNeedsDisplay()
    }
    
    func addHourLines() {
        let width = self.frame.width
        let height = self.frame.height
        let halfWidth: Double = Double(width/2)
        let halfHeight: Double = Double(height/2)
        
        let innerCircleRadius = halfWidth - 15.0
        let innerCircleDiameter = innerCircleRadius * 2
        
        let distance = 3.0
        
        let outerRadius: CGFloat = CGFloat(innerCircleRadius + distance)
        
        guard innerCircleDiameter <= Double(width) || innerCircleDiameter <= Double(height) else { return }
        
        for i in 0..<hours {
            let angle = CGFloat(i) * CGFloat(2 * Double.pi) / CGFloat(hours)
            if i == 9 {
                shadowAngle = angle
            }
            let numberPosition = CGPoint(x: outerRadius * cos(angle) + CGFloat(halfWidth), y: outerRadius * sin(angle) + CGFloat(halfHeight))
            addLabel(text: numbers[i], center: numberPosition)
        }
    }
    
    func addMinuteLines() {
        let width = self.frame.width
        let height = self.frame.height
        let halfWidth: Double = Double(width/2)
        let halfHeight: Double = Double(height/2)
        
        let path = UIBezierPath()
        
        let innerCircleRadius = halfWidth - 13.0
        let innerCircleDiameter = innerCircleRadius * 2
        
        let distance = 2.0
        
        let innerRadius: CGFloat = CGFloat(innerCircleRadius - distance)
        let outerRadius: CGFloat = CGFloat(innerCircleRadius + distance)
        
        guard innerCircleDiameter <= Double(width) || innerCircleDiameter <= Double(height) else { return }
        
        for i in 0..<minutes {
            if (i % 5) != 0 {
                let angle = CGFloat(i) * CGFloat(2 * Double.pi) / CGFloat(minutes)
                let inner = CGPoint(x: innerRadius * cos(angle) + CGFloat(halfWidth), y: innerRadius * sin(angle) + CGFloat(halfHeight))
                let outer = CGPoint(x: outerRadius * cos(angle) + CGFloat(halfWidth), y: outerRadius * sin(angle) + CGFloat(halfHeight))
                path.move(to: inner)
                path.addLine(to: outer)
            }
        }
        
        path.lineWidth = 1.0
        
        UIColor.white.setStroke()
        path.stroke()
    }
    
    func addHourHand(at position: Double) {
        let width = self.frame.width
        let height = self.frame.height
        let halfWidth: Double = Double(width/2)
        let halfHeight: Double = Double(height/2)
        
        let path = UIBezierPath()
        
        let hourHand: CGFloat = 65.0
        
        // the first angle is drawn at 3rd hour so subtracting 3 to draw the hand at the angle passed in parameter
        let hourAngle = CGFloat(position - 3) * CGFloat(2 * Double.pi) / CGFloat(hours)
        let center = CGPoint(x: CGFloat(halfWidth), y: CGFloat(halfHeight))
        let hour = CGPoint(x: hourHand * cos(hourAngle) + CGFloat(halfWidth), y: hourHand * sin(hourAngle) + CGFloat(halfHeight))
        path.move(to: center)
        path.addLine(to: hour)
        
        path.lineWidth = 2
        
        #colorLiteral(red: 1, green: 0.5530688317, blue: 0.6159807326, alpha: 1).setStroke()
        path.stroke()
    }
    
    func addMinuteHand(at position: Double) {
        let width = self.frame.width
        let height = self.frame.height
        let halfWidth: Double = Double(width/2)
        let halfHeight: Double = Double(height/2)
        
        let path = UIBezierPath()
        
        let minuteHand: CGFloat = 80.0
        
        // the first angle is drawn at 15th minute so subtracting 15 to draw the hand at the angle passed in parameter
        let minuteAngle = CGFloat(position - 15) * CGFloat(2 * Double.pi) / CGFloat(minutes)
        let center = CGPoint(x: CGFloat(halfWidth), y: CGFloat(halfHeight))
        let minute = CGPoint(x: minuteHand * cos(minuteAngle) + CGFloat(halfWidth), y: minuteHand * sin(minuteAngle) + CGFloat(halfHeight))
        path.move(to: center)
        path.addLine(to: minute)
        
        path.lineWidth = 1.5
        
        UIColor.white.setStroke()
        path.stroke()
    }
    
    func addSecondHand(at position: Double) {
        let width = self.frame.width
        let height = self.frame.height
        let halfWidth: Double = Double(width/2)
        let halfHeight: Double = Double(height/2)
        
        let path = UIBezierPath()
        
        let minuteHand: CGFloat = 90.0
        
        // the first angle is drawn at 15th second so subtracting 15 to draw the hand at the angle passed in parameter
        let secondAngle = CGFloat(position - 15) * CGFloat(2 * Double.pi) / CGFloat(seconds)
        let center = CGPoint(x: CGFloat(halfWidth), y: CGFloat(halfHeight))
        let second = CGPoint(x: minuteHand * cos(secondAngle) + CGFloat(halfWidth), y: minuteHand * sin(secondAngle) + CGFloat(halfHeight))
        path.move(to: center)
        path.addLine(to: second)
        
        path.lineWidth = 1.5
        
        UIColor.orange.setFill()
        path.fill()
        UIColor.yellow.setStroke()
        path.stroke()
    }
    
    func addShadow(at position: Double) {
        let width = self.frame.width
        let height = self.frame.height
        let halfWidth: Double = Double(width/2)
        let halfHeight: Double = Double(height/2)
        
        let path = UIBezierPath()
        
        let shadowRadius: CGFloat = CGFloat(halfWidth) - 15.0
        
        let secondAngle = CGFloat(position - 15) * CGFloat(2 * Double.pi) / CGFloat(seconds)
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
        //        label.layer.borderWidth = 0.5
        //        label.layer.cornerRadius = 7.5
        //        label.layer.masksToBounds = true
        //        label.layer.borderColor = UIColor.white.cgColor
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        self.addSubview(label)
    }
}
