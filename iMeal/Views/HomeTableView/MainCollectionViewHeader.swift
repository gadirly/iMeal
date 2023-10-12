//
//  MainCollectionViewHeader.swift
//  iMeal
//
//  Created by Babek Gadirli on 04.10.23.
//


import UIKit

class MainCollectionViewHeader: UICollectionReusableView {
    // MARK: Properties
    
    static let identifier = "MainCollectionViewHeader"
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    func configureUI() {
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor,
                          right: rightAnchor, paddingLeft: 20)
    }
    
    public func setText(text: String) {
        titleLabel.text = text
    }
}
