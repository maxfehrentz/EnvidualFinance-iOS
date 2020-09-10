//
//  CompanyCell.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 12.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit
import SnapKit

class CompanySearchCell: UITableViewCell {
    
    var delegate: SearchDelegate?
    
    let tickerLabel = UILabel()
    let companyNameLabel = UILabel()
    let likeButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAllSubviews()
        layout()
        configureCellAppearance()
        configureButton()
        configureTickerLabel()
        configureCompanyNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAllSubviews() {
        contentView.addSubview(tickerLabel)
        contentView.addSubview(companyNameLabel)
        contentView.addSubview(likeButton)
    }
    
    private func layout() {
        tickerLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
            make.width.equalToSuperview().multipliedBy(DesignConstants.half)
            make.bottom.equalTo(companyNameLabel.snp.top).offset(-DesignConstants.standardOffsetBetweenElements)
        }
        companyNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
            make.width.equalToSuperview().multipliedBy(DesignConstants.half)
        }
        likeButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(DesignConstants.quarter)
            make.height.equalTo(likeButton.snp.width)
            make.trailing.equalToSuperview()
        }
        // we do this to allow the button itself to be larger for easier interaction while the heart remains small
//        likeButton.imageView?.snp.makeConstraints({ (make) in
//            make.leading.trailing.equalToSuperview().inset(DesignConstants.insetForHeartSymbolHorizontal)
//            make.top.bottom.equalToSuperview().inset(DesignConstants.insetForHeartSymbolVertical)
//        })
    }
    
    private func configureCellAppearance() {
        selectionStyle = .none
    }
    
    private func configureButton() {
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setImage(UIImage(systemName: DesignConstants.sfSymbolNotLiked)?.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.setImage(UIImage(systemName: DesignConstants.sfSymbolLiked)?.withRenderingMode(.alwaysTemplate), for: .selected)
        likeButton.addTarget(self, action: #selector(self.likeButtonPressed), for: .touchUpInside)
        likeButton.tintColor = DesignConstants.pinkColor
        likeButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func likeButtonPressed(sender : UIButton) {
        if !sender.isSelected {
            // the ticker should never be null; if it is though we want the app to crash
            delegate?.addCompanyToFavourites(forTicker: tickerLabel.text!)
        }
        else {
            delegate?.removeCompanyFromFavourites(forTicker: tickerLabel.text!)
        }
        sender.isSelected = !sender.isSelected
    }
    
    private func configureTickerLabel() {
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        tickerLabel.adjustsFontSizeToFitWidth = true
        tickerLabel.numberOfLines = 0
        tickerLabel.textAlignment = .center
        tickerLabel.font = DesignConstants.companySearchCellTickerFont
    }
    
    private func configureCompanyNameLabel() {
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.adjustsFontSizeToFitWidth = true
        companyNameLabel.numberOfLines = 0
        companyNameLabel.textAlignment = .center
        companyNameLabel.font = DesignConstants.companySearchCellNameFont
    }
    

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    

}
