//
//  CustomTabBarController.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 14.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setColor()
    }
    
    private func setupItems() {
        if let items = self.tabBar.items {
            for (index, item) in items.enumerated() {
                item.image = UIImage(systemName: DesignConstants.sfSymbolsTabBar[index])
                item.title = DesignConstants.tabNames[index]
            }
        }
    }
    
    private func setColor() {
        tabBar.barTintColor = DesignConstants.navConBlue
        tabBar.tintColor = DesignConstants.pinkColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
