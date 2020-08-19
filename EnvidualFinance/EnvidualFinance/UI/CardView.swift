//
//  CardView.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 18.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var cornerRadius: CGFloat {
        50
    }
    
    var shadowColor: CGColor {
        return UIColor.gray.cgColor
    }
    
    var shadowOpacitiy: Float {
        10
    }
    var shadowOffset: CGSize {
        CGSize(width: 10, height: 10)
    }
    
    var color: UIColor {
        UIColor.white
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
