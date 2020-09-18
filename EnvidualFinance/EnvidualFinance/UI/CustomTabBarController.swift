//
//  CustomTabBarController.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 14.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import shared

class CustomTabBarController: UITabBarController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupTabBarAppearance()
        setupNavbarAppearance()
        setupTitlesForNavBar()
    }
    
    private func setupItems() {
        if let items = self.tabBar.items {
            for (index, item) in items.enumerated() {
                item.image = UIImage(systemName: DesignConstants.sfSymbolsTabBar[index])
                item.title = DesignConstants.tabNames[index]
            }
        }
    }
    
    private func setupTabBarAppearance() {
        tabBar.barTintColor = DesignConstants.navConBlue
        tabBar.tintColor = DesignConstants.pinkColor
    }
    
    private func setupNavbarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = DesignConstants.navConBlue
        appearance.titleTextAttributes = DesignConstants.attributesForNavBar
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupTitlesForNavBar() {
        // rx.didSelect only works after switching for the first time; we need to set the inital value by hand
        self.navigationController?.navigationBar.topItem?.title = DesignConstants.tabNames[0]
        rx.didSelect.subscribe(onNext: {
            if let tabBarItemTitle = self.tabBar.items?[self.selectedIndex].title {
                $0.navigationController?.navigationBar.topItem?.title = tabBarItemTitle
            }
        }).disposed(by: disposeBag)
    }
}
