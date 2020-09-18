//
//  CompanyNewsCollectionViewController.swift
//  EnvidualFinance
//
//  Created by Max on 10.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import shared

class CompanyNewsCollectionViewController: UIViewController {
    
    private let viewModel: CompanyNewsCollectionViewModel
    private let newsTableView = UITableView()
    private var activityIndicator = UIActivityIndicatorView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        addSubviews()
        layout()
        setupNewsTableView()
        setupActivityIndicator()
        viewModel.getNews()
    }
        
    init(viewModel: CompanyNewsCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(newsTableView)
        view.addSubview(activityIndicator)
    }
    
    private func layout() {
        newsTableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
                .multipliedBy(DesignConstants.activityIndicatorWidthAndHeightToSuperview)
            make.height.equalTo(activityIndicator.snp.width)
        }
    }
    
    private func setupNewsTableView() {
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 700
        newsTableView.layer.cornerRadius = DesignConstants.pageControllerCornerRadius
        bindTableView()
        setupSegues()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = DesignConstants.activityIndicatorColor
        viewModel.isLoadingNews
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        viewModel.news
            .bind(to: newsTableView.rx.items(cellIdentifier: "NewsCell")) { indexPath, news, cell in
                if let newsCell = cell as? NewsCell {
                    newsCell.headlineLabel.text = news.headline
                    // convert datetime given as Kotlinfloat to a proper Date
                    let date = Date(timeIntervalSince1970: news.datetime as! Double)
                    let formattedDate = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
                    newsCell.dateLabel.text = formattedDate
                    newsCell.sourceLabel.text = news.source
                }
        }
        .disposed(by: disposeBag)
    }
    
    private func setupSegues() {
        newsTableView.rx.itemSelected.subscribe(onNext: { [weak self] in
            if let newsForSegue = self?.viewModel.news.value[$0.row] {
                self?.present(NewsViewController(viewModel: NewsViewModel(news: newsForSegue)), animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
    }
    
    func hideTableView() {
        newsTableView.isHidden = true
    }
}


