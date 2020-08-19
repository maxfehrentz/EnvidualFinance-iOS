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
    private var cardView = CardView()
    private var nameLabel = UILabel()
    private var tickerLabel = UILabel()
    private var countryLabel = UILabel()
    private var valueLabel = UILabel()
    private var industryLabel = UILabel()
    private var ipoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground(colorTop: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), colorBottom: Constants.envidualBlue)
        addAllSubviews()
        layout()
        configureLogo()
        configureCardView()
        configureLabels()
        // Do any additional setup after loading the view.
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addAllSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(logo)
        view.addSubview(cardView)
        cardView.addSubview(tickerLabel)
        cardView.addSubview(countryLabel)
        cardView.addSubview(valueLabel)
        cardView.addSubview(industryLabel)
        cardView.addSubview(ipoLabel)
    }
    
    private func layout() {
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.left.right.equalToSuperview().inset(5)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        logo.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(logo.snp.width)
        }
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(logo.snp.bottom).offset(30)
            make.left.right.bottom.equalToSuperview()
        }
        tickerLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(0.33333)
        }
        countryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tickerLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(0.33333)
        }
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(countryLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(0.33333)
        }
        industryLabel.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(cardView.snp.centerX)
            make.bottom.equalTo(cardView.snp.centerY)
        }
        ipoLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.equalTo(industryLabel.snp.bottom)
            make.leading.equalTo(cardView.snp.centerX)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureLogo() {
        logo.kf.setImage(with: URL(string: company.logo!))
        logo.layer.cornerRadius = 30
        logo.layer.masksToBounds = true
    }
    
    private func configureCardView() {
        cardView.backgroundColor = cardView.color
        cardView.layer.cornerRadius = cardView.cornerRadius
        cardView.layer.shadowOffset = cardView.shadowOffset
        cardView.layer.shadowColor = cardView.shadowColor
        cardView.layer.shadowOpacity = cardView.shadowOpacitiy
    }
    
    private func configureLabels() {
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        let nameLabelFont = UIFont.systemFont(ofSize: 40, weight: .heavy)
        let attributes = [NSAttributedString.Key.font : nameLabelFont, NSAttributedString.Key.foregroundColor : UIColor.white]
        let attributedString = NSAttributedString(string: company.name ?? "", attributes: attributes)
        nameLabel.attributedText = attributedString

        
        setBasicLabelProperties(for: tickerLabel)
        if let ticker = company.ticker {
            tickerLabel.text = "Ticker:\n\(ticker)"
        }
        else {
            tickerLabel.text = "Ticker:\n"
        }
        
        setBasicLabelProperties(for: countryLabel)
        if let country = company.country {
            countryLabel.text = "Country:\n\(country)"
        }
        else {
            countryLabel.text = "Country:\n"
        }
        
        setBasicLabelProperties(for: valueLabel)
        if let value = company.marketCapitalization, let curr = company.currency {
            valueLabel.text = "Value:\n\(value) \(curr)"
        }
        else {
            valueLabel.text = "Value:\n"
        }
        
        setBasicLabelProperties(for: industryLabel)
        if let industry = company.finnhubIndustry {
            industryLabel.text = "Industry:\n\(industry)"
        }
        else {
            industryLabel.text = "Industry:\n"
        }
        
        setBasicLabelProperties(for: ipoLabel)
        if let ipo = company.ipo {
            ipoLabel.text = "IPO:\n\(ipo)"
        }
        else {
            ipoLabel.text = "IPO:\n"
        }
    }
    
    private func setBasicLabelProperties(for label: UILabel) {
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .light)
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
