//
//  CategoryCell.swift
//  iMeal
//
//  Created by Babek Gadirli on 11.10.23.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let identifier = "CategoryCell"
    
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
    
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    private func configureUI() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        
        contentView.addSubview(mealImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(desscriptionLabel)
        
        
        mealImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 220)
        
        titleLabel.anchor(top: mealImageView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        desscriptionLabel.anchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 4, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
    }
    
    public func configureCell(with category: Category) {
        
        guard let imageUrl = URL(string: category.strCategoryThumb) else {
            return
        }
        mealImageView.sd_setImage(with: imageUrl)
        titleLabel.text = category.strCategory
        desscriptionLabel.text = category.strCategoryDescription
    }
    
    
}
