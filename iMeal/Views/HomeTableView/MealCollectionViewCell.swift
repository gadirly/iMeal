//
//  MealCollectionViewCell.swift
//  iMeal
//
//  Created by Babek Gadirli on 02.10.23.
//

import UIKit
import SDWebImage

class MealCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    static let identifier = "MealCollectionViewCell"
    
    
    private let mealImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let ratingIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .orange
        return imageView
    }()
    
    private let scoreLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = UIColor.black
        label.textAlignment = .right
        return label
    }()
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        label.textColor = UIColor.black
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(mealImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(ratingIcon)
        scoreLabel.text = String(randomBetween4And5WithDecimal())
        titleLabel.text = "Beef Stroganoff"
        mealImageView.image = UIImage(named: "meal")
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    // MARK: Helpers
    
    func configureUI() {
        mealImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingBottom: 30)
        
        
        titleLabel.anchor(top: mealImageView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingRight: 50)
        
        scoreLabel.anchor(top: mealImageView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10,
        paddingRight: 20)
        
        ratingIcon.anchor(top: mealImageView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 12, width: 16, height: 16)
    }
    
    func configureCell(with posterUrl: String, title: String) {
        titleLabel.text = title
        
        guard let url = URL(string: posterUrl) else {
            return
        }
        
        mealImageView.sd_setImage(with: url, completed: nil)
        
    }
    
    func randomBetween4And5WithDecimal() -> Double {
        let randomValue = Double(arc4random() % 11) / 10.0
        let scaledValue = randomValue + 4.0
        
        return scaledValue
    }
}
