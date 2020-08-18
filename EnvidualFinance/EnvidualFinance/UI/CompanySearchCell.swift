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
    
    var ticker: String? {
        didSet {
            setNeedsLayout()
        }
    }
    
    var name: String? {
        didSet {
            setNeedsLayout()
        }
    }
    
    var isFavorite: Bool? {
        didSet {
            setNeedsLayout()
        }
    }
    
    var delegate: SearchDelegate?
    
    private var tickerLabel = UILabel()
    private var companyNameLabel = UILabel()
    private var likeButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAllSubviews()
        layout()
        configureButton()
        configureTickerLabel()
        configureCompanyNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tickerLabel.text = ticker
        companyNameLabel.text = name
        likeButton.isSelected = isFavorite ?? false
    }
    
    private func addAllSubviews() {
        contentView.addSubview(tickerLabel)
        contentView.addSubview(companyNameLabel)
        contentView.addSubview(likeButton)
    }
    
    private func layout() {
        tickerLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.33)
        }
        companyNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tickerLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        likeButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func configureButton() {
        likeButton.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate), for: .selected)
//        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeButton.addTarget(self, action: #selector(self.likeButtonPressed), for: .touchUpInside)
        likeButton.tintColor = Constants.pinkColor
    }
    
    @objc private func likeButtonPressed(sender : UIButton) {
        if !sender.isSelected {
            // the ticker should never be null; if it is though we want the app to crash
            delegate?.addCompanyToFavourites(forTicker: ticker!)
        }
        else {
            delegate?.removeCompanyFromFavourites(forTicker: ticker!)
        }
        sender.isSelected = !sender.isSelected
    }
    
    private func configureTickerLabel() {
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        tickerLabel.adjustsFontSizeToFitWidth = true
        tickerLabel.numberOfLines = 0
        tickerLabel.textAlignment = .center
        tickerLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    private func configureCompanyNameLabel() {
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.adjustsFontSizeToFitWidth = true
        companyNameLabel.numberOfLines = 0
        companyNameLabel.textAlignment = .center
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
