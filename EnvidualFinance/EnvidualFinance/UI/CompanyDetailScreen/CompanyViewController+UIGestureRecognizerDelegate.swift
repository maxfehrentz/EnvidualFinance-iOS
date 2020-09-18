//
//  CompanyViewController+UIGestureRecognizerDelegate.swift
//  EnvidualFinance
//
//  Created by Max on 18.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import UIKit

// screen is presented modally; OS gets confused if gesture is supposed to target sheet (screen) or cardView; we need this method to clear up the confusion
extension CompanyViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
