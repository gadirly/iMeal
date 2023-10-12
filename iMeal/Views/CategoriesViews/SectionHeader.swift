//
//  SectionHeader.swift
//  iMeal
//
//  Created by Babek Gadirli on 11.10.23.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let identifier = "SectionHeader"
    
    // MARK: Properties
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Explore meals by category 🍕"
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
    
    func configureUI() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor,
                          right: rightAnchor, paddingLeft: 20)
    }
    
    public func setText(text: String) {
        titleLabel.text = text
    }
}
