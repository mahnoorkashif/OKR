//
//  Animation1.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 29/11/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class Animation1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addGradient()
        addClock()
        addNumberClock()
    }
}

extension Animation1 {
    func addGradient() {
        let colors : [UIColor] = [#colorLiteral(red: 1, green: 0.6078431373, blue: 0.5725490196, alpha: 1), #colorLiteral(red: 0.2990502451, green: 0.7843137255, blue: 0.7647058824, alpha: 1)]
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addClock() {
        let width: CGFloat = 240.0
        let height: CGFloat = 240.0
        let clockView = ClockView(frame: CGRect(x: self.view.frame.size.width/2 - width/2, y: 2.5 * (self.navigationController?.navigationBar.frame.height ?? 100), width: width, height: height))
        clockView.backgroundColor = .clear
        clockView.layer.cornerRadius = clockView.frame.width/2
        clockView.layer.masksToBounds = true
        self.view.addSubview(clockView)
    }
    
    func addNumberClock() {
        let width: CGFloat = 240.0
        let height: CGFloat = 240.0
        let clockView = ClockWithNumbers(frame: CGRect(x: self.view.frame.size.width/2 - width/2, y: self.view.frame.size.height - height - 20, width: width, height: height))
        clockView.backgroundColor = .clear
        clockView.layer.cornerRadius = clockView.frame.width/2
        clockView.layer.masksToBounds = true
        self.view.addSubview(clockView)
    }
}
