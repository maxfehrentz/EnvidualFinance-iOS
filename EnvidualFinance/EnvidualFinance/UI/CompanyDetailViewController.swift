//
//  CompanyDetailViewController.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 18.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit
import shared
import SnapKit
import Kingfisher

class CompanyDetailViewController: UIViewController {
    
    var company: CompanyData!
    
    private var logo = UIImageView()
    private var nameLabel = UILabel()
    private var tickerLabel = UILabel()
    private var countryLabel = UILabel()
    private var valueLabel = UILabel()
    private var industryLabel = UILabel()
    private var ipoLabel = UILabel()
    private var verticalStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSubviews()
        layout()
        configureStackView()
        configureLogo()
        configureLabels()
        // Do any additional setup after loading the view.
    }
    
    private func addAllSubviews() {
        view.addSubview(verticalStackView)
    }
    
    private func layout() {
        verticalStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func configureStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.addArrangedSubview(logo)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(tickerLabel)
        verticalStackView.addArrangedSubview(countryLabel)
        verticalStackView.addArrangedSubview(valueLabel)
        verticalStackView.addArrangedSubview(industryLabel)
        verticalStackView.addArrangedSubview(ipoLabel)
    }
    
    private func configureLogo() {
        logo.kf.setImage(with: URL(string: company.logo!)) { result in
            switch result {
            case .success(_):
                print("retrieving image was successful")
            case .failure(_):
                print("retrieving image failed")
            }
        }
    }
    
    private func configureLabels() {
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        if let name = company.name {
            nameLabel.text = "Name:\n\(name)"
        }
        else {
            nameLabel.text = "Name:\n"
        }
        
        tickerLabel.adjustsFontSizeToFitWidth = true
        tickerLabel.numberOfLines = 0
        tickerLabel.textAlignment = .center
        if let ticker = company.ticker {
            tickerLabel.text = "Ticker:\n\(ticker)"
        }
        else {
            tickerLabel.text = "Ticker:\n"
        }
        
        countryLabel.adjustsFontSizeToFitWidth = true
        countryLabel.numberOfLines = 0
        countryLabel.textAlignment = .center
        if let country = company.country {
            countryLabel.text = "Country:\n\(country)"
        }
        else {
            countryLabel.text = "Country:\n"
        }
        
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.numberOfLines = 0
        valueLabel.textAlignment = .center
        if let value = company.marketCapitalization, let curr = company.currency {
            valueLabel.text = "Value:\n\(value) \(curr)"
        }
        else {
            valueLabel.text = "Value:\n"
        }
        
        industryLabel.adjustsFontSizeToFitWidth = true
        industryLabel.numberOfLines = 0
        industryLabel.textAlignment = .center
        if let industry = company.finnhubIndustry {
            industryLabel.text = "Industry:\n\(industry)"
        }
        else {
            industryLabel.text = "Industry:\n"
        }
        
        ipoLabel.adjustsFontSizeToFitWidth = true
        ipoLabel.numberOfLines = 0
        ipoLabel.textAlignment = .center
        if let ipo = company.ipo {
            ipoLabel.text = "IPO:\n\(ipo)"
        }
        else {
            ipoLabel.text = "IPO:\n"
        }
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
