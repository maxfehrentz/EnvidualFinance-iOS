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
import RxSwift
import RxDataSources

class CompanyDetailViewController: UIViewController {
    
    var viewModel: CompanyDetailViewModel!
    
    private let logo = UIImageView()
    private let cardView = CardView()
    private let nameLabel = UILabel()
    private let tickerLabel = UILabel()
    private let countryLabel = UILabel()
    private let valueLabel = UILabel()
    private let industryLabel = UILabel()
    private let ipoLabel = UILabel()
    private let shareOutstandingLabel = UILabel()
    private let newsTableView = UITableView()
    private let pageControl = UIPageControl()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DesignConstants.setGradientBackground(for: view, colorTop: DesignConstants.standardPurple, colorBottom: DesignConstants.pinkColor)
        addAllSubviews()
        layout()
        configureLogo()
        configureCardView()
        configureLabels()
        setupNewsTableView()
        configurePageControl()
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
        cardView.addSubview(shareOutstandingLabel)
        cardView.addSubview(newsTableView)
        cardView.addSubview(pageControl)
    }
    
    private func layout() {
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(DesignConstants.detailVcNameLabelOffsetFromTop)
            make.left.right.equalToSuperview().inset(DesignConstants.minInsetFromEdges)
            make.height.equalToSuperview().multipliedBy(DesignConstants.flatLabelHeightToSuperview)
        }
        logo.snp.makeConstraints { (make) in make.top.equalTo(nameLabel.snp.bottom).offset(DesignConstants.detailVcOffsetBetweenLargeElements)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(DesignConstants.half)
            make.height.equalTo(logo.snp.width)
        }
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(logo.snp.bottom)
            .offset(DesignConstants.detailVcOffsetBetweenLargeElements)
            make.left.right.bottom.equalToSuperview()
        }
        tickerLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        countryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tickerLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(countryLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        industryLabel.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        ipoLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.equalTo(industryLabel.snp.bottom)
            make.leading.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        shareOutstandingLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.equalTo(ipoLabel.snp.bottom)
            make.leading.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        newsTableView.snp.makeConstraints { (make) in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(cardView.snp.height).multipliedBy(DesignConstants.newsTableViewHeightToCardHeight)
        }
        pageControl.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
    
    private func configureLogo() {
        logo.kf.setImage(with: URL(string: viewModel.company.logo!))
        logo.contentMode = .scaleAspectFit
        logo.layer.cornerRadius = DesignConstants.logoCornerRadius
        logo.layer.masksToBounds = true
    }
    
    private func configureCardView() {
        cardView.backgroundColor = cardView.color
        cardView.layer.cornerRadius = cardView.cornerRadius
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        swipeLeftGesture.direction = .left
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        swipeRightGesture.direction = .right
        cardView.addGestureRecognizer(swipeLeftGesture)
        cardView.addGestureRecognizer(swipeRightGesture)
        swipeLeftGesture.delegate = self
        swipeRightGesture.delegate = self
    }
    
    @objc private func swipeLeft() {
        hideLabels()
        makeNewsTableViewAppear()
        pageControl.currentPage = 1
    }
    
    @objc private func swipeRight() {
        hideNewsTableView()
        makeLabelsAppear()
        pageControl.currentPage = 0
    }
    
    private func hideLabels() {
        tickerLabel.isHidden = true
        countryLabel.isHidden = true
        valueLabel.isHidden = true
        industryLabel.isHidden = true
        ipoLabel.isHidden = true
        shareOutstandingLabel.isHidden = true
    }
    
    private func makeNewsTableViewAppear() {
        newsTableView.isHidden = false
    }
    
    private func hideNewsTableView() {
        newsTableView.isHidden = true
    }
    
    private func makeLabelsAppear() {
        tickerLabel.isHidden = false
        countryLabel.isHidden = false
        valueLabel.isHidden = false
        industryLabel.isHidden = false
        ipoLabel.isHidden = false
        shareOutstandingLabel.isHidden = false
    }
    
    private func configureLabels() {
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        let nameLabelFont = DesignConstants.detailVcNameFont
        let attributes = [NSAttributedString.Key.font : nameLabelFont, NSAttributedString.Key.foregroundColor : DesignConstants.detailVcNameFontColor]
        let attributedString = NSAttributedString(string: viewModel.company.name ?? "", attributes: attributes)
        nameLabel.attributedText = attributedString

        
        setBasicLabelProperties(for: tickerLabel)
        if let ticker = viewModel.company.ticker {
            tickerLabel.text = "Ticker:\n\(ticker)"
        }
        else {
            tickerLabel.text = "Ticker:\n"
        }
        
        setBasicLabelProperties(for: countryLabel)
        if let country = viewModel.company.country {
            countryLabel.text = "Country:\n\(country)"
        }
        else {
            countryLabel.text = "Country:\n"
        }
        
        setBasicLabelProperties(for: valueLabel)
        if let value = viewModel.company.marketCapitalization, let curr = viewModel.company.currency {
            valueLabel.text = "Value:\n\(value) \(curr)"
        }
        else {
            valueLabel.text = "Value:\n"
        }
        
        setBasicLabelProperties(for: industryLabel)
        if let industry = viewModel.company.finnhubIndustry {
            industryLabel.text = "Industry:\n\(industry)"
        }
        else {
            industryLabel.text = "Industry:\n"
        }
        
        setBasicLabelProperties(for: ipoLabel)
        if let ipo = viewModel.company.ipo {
            ipoLabel.text = "IPO:\n\(ipo)"
        }
        else {
            ipoLabel.text = "IPO:\n"
        }
        
        setBasicLabelProperties(for: shareOutstandingLabel)
        if let shareOutstanding = viewModel.company.shareOutstanding, let curr = viewModel.company.currency {
            shareOutstandingLabel.text = "Share Outstanding:\n\(shareOutstanding) \(curr)"
        }
        else {
            shareOutstandingLabel.text = "Share Outstanding:\n"
        }
    }
    
    private func setBasicLabelProperties(for label: UILabel) {
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = DesignConstants.detailVcCardViewLabelsFont
    }
    
    private func setupNewsTableView() {
        newsTableView.isHidden = true
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 700
        newsTableView.layer.cornerRadius = DesignConstants.cardViewCornerRadius
        bindTableView()
    }
    
    private func bindTableView() {
        viewModel.news
            .bind(to: newsTableView.rx.items(cellIdentifier: "NewsCell")) { indexPath, news, cell in
                if let newsCell = cell as? NewsCell {
                    newsCell.headlineLabel.text = news.headline
                    // convert datetime given as Kotlinfloat to a proper Date
                    let date = Date(timeIntervalSince1970: news.datetime as! Double)
                    let formattedDate = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
                    newsCell.dateLabel.text = "\(formattedDate)"
                    newsCell.sourceLabel.text = news.source
                }
        }
        .disposed(by: disposeBag)
    }
    
    private func configurePageControl() {
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = DesignConstants.pinkColor
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
    }

}

extension CompanyDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

