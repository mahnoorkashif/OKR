//
//  Animation1.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 29/11/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class Animation1: UIViewController {
    
    var clockView           : ClockView?
    var clockWithNumbers    : ClockWithNumbers?

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
    private func addGradient() {
        let colors : [UIColor] = [#colorLiteral(red: 1, green: 0.6078431373, blue: 0.5725490196, alpha: 1), #colorLiteral(red: 0.2990502451, green: 0.7843137255, blue: 0.7647058824, alpha: 1)]
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addClock() {
        let width: CGFloat = 240.0
        let height: CGFloat = 240.0
        clockView = ClockView(frame: CGRect(x: self.view.frame.size.width/2 - width/2, y: 2.5 * (self.navigationController?.navigationBar.frame.height ?? 100), width: width, height: height))
        clockView?.backgroundColor = .clear
        clockView?.layer.cornerRadius = (clockView?.frame.width ?? 0)/2
        clockView?.layer.masksToBounds = true
        guard let clockView  = self.clockView else { return }
        self.view.addSubview(clockView)
    }
    
    private func addNumberClock() {
        let width: CGFloat = 240.0
        let height: CGFloat = 240.0
        clockWithNumbers = ClockWithNumbers(frame: CGRect(x: self.view.frame.size.width/2 - width/2, y: (2.5 * (self.navigationController?.navigationBar.frame.height ?? 100)) + ((clockView?.frame.height ?? 0) + 40), width: width, height: height))
        clockWithNumbers?.backgroundColor = .clear
        clockWithNumbers?.layer.cornerRadius = (clockWithNumbers?.frame.width ?? 0)/2
        clockWithNumbers?.layer.masksToBounds = true
        guard let clockWithNumbers  = self.clockWithNumbers else { return }
        self.view.addSubview(clockWithNumbers)
    }
}
