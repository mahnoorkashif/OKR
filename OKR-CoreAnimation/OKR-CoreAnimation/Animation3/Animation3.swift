//
//  Animation3.swift
//  OKR-CoreAnimation
//
//  Created by Mahnoor Khan on 02/12/2019.
//  Copyright © 2019 Mahnoor Khan. All rights reserved.
//

import UIKit

class Animation3: UIViewController {

    @IBOutlet weak var imageView    : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateImageView()
    }
}

extension Animation3 {
    private func animateImageView() {
        let scale = CGAffineTransform(scaleX: 2.0, y: 2.0)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.imageView.transform = scale
        }, completion: nil)
    }
}
