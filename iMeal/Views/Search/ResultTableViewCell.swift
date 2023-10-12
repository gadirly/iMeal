//
//  ResultTableViewCell.swift
//  iMeal
//
//  Created by Babek Gadirli on 10.10.23.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    static let identifier = "ResultTableViewCell"
    
    // MARK: Properties
    
    private let mealImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let desscriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Helpers
    
    private func configureUI() {
        contentView.addSubview(mealImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(desscriptionLabel)
        
        mealImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 220)
        
        titleLabel.anchor(top: mealImageView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        desscriptionLabel.anchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 4, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
    }
    
    public func configureCell(with model: Recipe) {
        
        guard let imageUrl = URL(string: model.strMealThumb) else {
            return
        }
        
        mealImageView.sd_setImage(with: imageUrl)
        titleLabel.text = model.strMeal
        desscriptionLabel.text = model.strInstructions
        
        print(model.strMeal)
    }
    
}
