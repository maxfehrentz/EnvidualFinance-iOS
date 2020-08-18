//
//  CustomTabBarController.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 14.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    // sf symbols used from left to right as Strings
    let sfSymbols = ["suit.heart", "magnifyingglass"]
    let tabNames = ["Favorites", "Search"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setColor()
    }
    
    private func setupItems() {
        if let items = self.tabBar.items {
            for (index, item) in items.enumerated() {
                item.image = UIImage(systemName: sfSymbols[index])
                item.title = tabNames[index]
            }
        }
    }
    
    private func setColor() {
        tabBar.barTintColor = Constants.envidualBlue
        tabBar.tintColor = Constants.pinkColor
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
