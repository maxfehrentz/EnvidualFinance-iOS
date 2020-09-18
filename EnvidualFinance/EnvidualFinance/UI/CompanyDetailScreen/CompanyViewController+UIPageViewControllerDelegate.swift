//
//  CompanyViewController+UIPageViewControllerDelegate.swift
//  EnvidualFinance
//
//  Created by Max on 18.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import UIKit

extension CompanyViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let currentViewController = pageViewController.presentedViewController {
            return pages.firstIndex(of: currentViewController)!
        }
        return 0
    }
}
