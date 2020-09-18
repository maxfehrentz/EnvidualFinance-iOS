//
//  SearchViewController+ErrorDelegate.swift
//  EnvidualFinance
//
//  Created by Max on 18.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: ErrorDelegate {
    func showError(for errorMessage: String) {
        let alertController = UIAlertController(title: "Ups!", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alertController, animated: true, completion: nil)
    }
}
