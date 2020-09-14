//
//  NewsViewController.swift
//  EnvidualFinance
//
//  Created by Max on 01.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit
import shared
import SnapKit
import Kingfisher
import SafariServices

class NewsViewController: UIViewController {
    
    var viewModel: NewsViewModel
    
    private let scrollView = UIScrollView()
    private let articleImageView = UIImageView()
    private let headlineLabel = UILabel()
    private let articleTextLabel = UILabel()
    private let dateLabel = UILabel()
    private let sourceLabel = UILabel()
    private let linkLabel = UILabel()
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        addAllSubviews()
        layout()
        configureScrollView()
        configureImageView()
        configureHeadlineLabel()
        configureTextLabel()
        configureDateLabel()
        configureSourceLabel()
        configureLinkLabel()
    }
    
    private func configureAppearance() {
        view.backgroundColor = .white
    }
    
    private func addAllSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(articleImageView)
        scrollView.addSubview(headlineLabel)
        scrollView.addSubview(articleTextLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(sourceLabel)
        scrollView.addSubview(linkLabel)
    }
    
    private func layout() {
        scrollView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        articleImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
            make.height.equalToSuperview().multipliedBy(DesignConstants.half)
            make.width.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
        }
        headlineLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
            make.top.equalTo(articleImageView.snp.bottom).offset(DesignConstants.offsetBetweenNewsViewControllerLabels)
            make.width.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
        }
        articleTextLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
            make.top.equalTo(headlineLabel.snp.bottom).offset(DesignConstants.offsetBetweenNewsViewControllerLabels)
            make.width.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
            make.top.equalTo(articleTextLabel.snp.bottom).offset(DesignConstants.offsetBetweenNewsViewControllerLabels)
            make.width.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
        }
        sourceLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
            make.top.equalTo(dateLabel.snp.bottom).offset(DesignConstants.offsetBetweenNewsViewControllerLabels)
            make.width.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
        }
        linkLabel.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
            make.top.equalTo(sourceLabel.snp.bottom).offset(DesignConstants.offsetBetweenNewsViewControllerLabels)
            make.width.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
        }
    }
    
    private func configureScrollView() {
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func configureImageView() {
        articleImageView.contentMode = .scaleAspectFit
        if let imageURLString = viewModel.news.image {
            articleImageView.kf.setImage(with: URL(string: imageURLString))
        }
    }
    
    private func configureHeadlineLabel() {
        basicSetup(for: headlineLabel)
        headlineLabel.font = DesignConstants.fontForNewsHeadline
        headlineLabel.textAlignment = .center
        headlineLabel.text = viewModel.news.headline
    }
    
    private func configureTextLabel() {
        basicSetup(for: articleTextLabel)
        articleTextLabel.textAlignment = .center
        articleTextLabel.text = viewModel.news.summary
    }
    
    private func configureDateLabel() {
        basicSetup(for: dateLabel)
        dateLabel.textAlignment = .right
        // transform datetime to proper date
        let date = Date(timeIntervalSince1970: viewModel.news.datetime as! Double)
        let formattedDate = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
        dateLabel.text = formattedDate
    }
    
    private func configureSourceLabel() {
        basicSetup(for: sourceLabel)
        sourceLabel.textAlignment = .right
        sourceLabel.text = viewModel.news.source
    }
    
    private func configureLinkLabel() {
        basicSetup(for: linkLabel)
        linkLabel.textColor = .blue
        linkLabel.textAlignment = .right
        linkLabel.text = viewModel.news.url
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToURL))
        linkLabel.addGestureRecognizer(tapGesture)
        linkLabel.isUserInteractionEnabled = true
    }
    
    @objc private func goToURL() {
        if let urlString = linkLabel.text {
            if let url = URL(string: urlString) {
                let safariVc = SFSafariViewController(url: url)
                present(safariVc, animated: true)
            }
        }
    }
    
    private func basicSetup(for label: UILabel) {
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignConstants.fontForNewsViewControllerLabels
    }

}
