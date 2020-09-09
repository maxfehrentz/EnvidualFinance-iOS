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
            make.top.equalToSuperview().offset(DesignConstants.standardInsetFromEdges)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(DesignConstants.half)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        companyNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tickerLabel.snp.bottom)
                .offset(DesignConstants.standardOffsetBetweenElements)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(DesignConstants.standardInsetFromEdges)
            make.trailing.equalTo(likeButton.snp.leading)
                .offset(DesignConstants.standardInsetFromEdges)
        }
        likeButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-DesignConstants.standardInsetFromEdges)
        }
    }
    
    private func configureCellAppearance() {
        selectionStyle = .none
    }
    
    private func configureButton() {
        likeButton.setImage(UIImage(systemName: DesignConstants.sfSymbolNotLiked)?.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.setImage(UIImage(systemName: DesignConstants.sfSymbolLiked)?.withRenderingMode(.alwaysTemplate), for: .selected)
        likeButton.addTarget(self, action: #selector(self.likeButtonPressed), for: .touchUpInside)
        likeButton.tintColor = DesignConstants.pinkColor
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
