//
//  NewsCell.swift
//  EnvidualFinance
//
//  Created by Max on 01.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit
import SnapKit

class NewsCell: UITableViewCell {
    
    let headlineLabel = UILabel()
    let dateLabel = UILabel()
    let sourceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAllSubviews()
        layout()
        configureHeadlineLabel()
        configureDateLabel()
        configureSourceLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAllSubviews() {
        contentView.addSubview(headlineLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(sourceLabel)
    }
    
    private func layout() {
        headlineLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headlineLabel.snp.bottom).offset(DesignConstants.standardOffsetBetweenElements)
            make.leading.bottom.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
            make.trailing.equalTo(contentView.snp.centerX).offset(-DesignConstants.standardOffsetBetweenElements / 2)
        }
        sourceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headlineLabel.snp.bottom).offset(DesignConstants.standardOffsetBetweenElements)
            make.trailing.bottom.equalToSuperview().inset(DesignConstants.standardInsetFromEdges)
            make.leading.equalTo(contentView.snp.centerX).offset(DesignConstants.standardOffsetBetweenElements / 2)
        }
    }
    
    private func configureHeadlineLabel() {
        basicSetup(for: headlineLabel)
        headlineLabel.font = DesignConstants.fontForHeadlineInNewsCell
    }
    
    private func configureDateLabel() {
        basicSetup(for: dateLabel)
    }
    
    private func configureSourceLabel() {
        basicSetup(for: sourceLabel)
    }
    
    private func basicSetup(for label: UILabel) {
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
