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

class CompanyViewController: UIViewController {
    
    var viewModel: CompanyViewModel!
    
    private let logo = UIImageView()
    private let nameLabel = UILabel()
    private let disposeBag = DisposeBag()
    private let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private(set) var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViewControllers()
        DesignConstants.setGradientBackground(for: view, colorTop: DesignConstants.standardPurple, colorBottom: DesignConstants.pinkColor)
        addAllSubviews()
        layout()
        setupPageController()
        configureLogo()
        configureLabel()
    }
    
    private func createViewControllers() {
        let companyNewsCollectionViewModel = CompanyNewsCollectionViewModel(company: viewModel.company)
        let companyNewsCollectionViewController = CompanyNewsCollectionViewController(viewModel: companyNewsCollectionViewModel)
        companyNewsCollectionViewModel.errorDelegate = companyNewsCollectionViewController
        pages = [CompanySpecificsViewController(viewModel: CompanySpecificsViewModel(company: viewModel.company)), companyNewsCollectionViewController]
    }
    
    private func addAllSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(logo)
        view.addSubview(pageController.view)
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
        pageController.view.snp.makeConstraints { (make) in
            make.top.equalTo(logo.snp.bottom)
                .offset(DesignConstants.detailVcOffsetBetweenLargeElements)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func layoutNoImage() {
        logo.removeFromSuperview()
        pageController.view.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
                .offset(DesignConstants.detailVcOffsetBetweenLargeElements)
        }
    }
    
    private func setupPageController() {
        pageController.dataSource = self
        pageController.delegate = self
        pageController.view.backgroundColor = .white
        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParent: self)
        pageController.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        // create the rounded corners on top
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: DesignConstants.pageControllerCornerRadius, height: DesignConstants.pageControllerCornerRadius)).cgPath
        pageController.view.layer.mask = maskLayer
    }
    
    private func configureLogo() {
        logo.kf.setImage(with: URL(string: viewModel.company.logo!), completionHandler: {[weak self] result in
            switch result {
            case .failure:
                self?.layoutNoImage()
            default:
                print("Fetching image was succesful")
            }
        })
        logo.contentMode = .scaleAspectFit
        logo.layer.cornerRadius = DesignConstants.logoCornerRadius
        logo.layer.masksToBounds = true
    }
    
    private func configureLabel() {
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        let nameLabelFont = DesignConstants.detailVcNameFont
        let attributes = [NSAttributedString.Key.font : nameLabelFont, NSAttributedString.Key.foregroundColor : DesignConstants.detailVcNameFontColor]
        let attributedString = NSAttributedString(string: viewModel.company.name ?? "", attributes: attributes)
        nameLabel.attributedText = attributedString
    }
    
}

