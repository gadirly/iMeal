//
//  RandomMealCell.swift
//  iMeal
//
//  Created by Babek Gadirli on 11.10.23.
//

import UIKit

class RandomMealCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let identifier = "RandomMealCell"
    
    private let cardView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private let mealImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.text = "4.9"
        return label
    }()
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.textColor = UIColor.black
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
        
        contentView.layer.cornerRadius = 15
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor

       
        
        
        contentView.addSubview(cardView)
        cardView.addSubview(mealImageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(scoreLabel)
        cardView.addSubview(ratingIcon)
        
        cardView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        
        mealImageView.anchor(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: cardView.bottomAnchor, right: cardView.rightAnchor, paddingBottom: 50)
        
        titleLabel.anchor(top: mealImageView.bottomAnchor, left: cardView.leftAnchor, right: cardView.rightAnchor,
        paddingTop: 10, paddingLeft: 10, paddingRight: 55)
        
        scoreLabel.anchor(top: mealImageView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10,
        paddingRight: 25)
        
        ratingIcon.anchor(right: contentView.rightAnchor, paddingRight: 5, width: 15, height: 15)
        
        ratingIcon.centerY(inView: scoreLabel)
    }
    
    public func configureCell(with model: Recipe) {
        guard let imageUrl = URL(string: model.strMealThumb) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.mealImageView.sd_setImage(with: imageUrl)
            self?.titleLabel.text = model.strMeal
        }
        
        
    }
}
