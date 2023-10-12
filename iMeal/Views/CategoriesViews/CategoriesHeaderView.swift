//
//  CategoriesHeaderView.swift
//  iMeal
//
//  Created by Babek Gadirli on 11.10.23.
//

import UIKit

protocol CategoriesHeaderViewDelegate: AnyObject {
    func CategoriesHeaderViewDidTapCell(_ cell: CategoriesHeaderView, model: Recipe)
}

class CategoriesHeaderView: UICollectionReusableView {
    
    static let identifier = "CategoriesHeaderView"
    
    var viewModel = HomeViewModel()
    
    // MARK: Properties
    
    weak var delegate: CategoriesHeaderViewDelegate?
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Top 5 meals 😍"
        return label
    }()
    
    private let randomMealsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RandomMealCell.self, forCellWithReuseIdentifier: RandomMealCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    private func configureUI() {
        addSubview(titleLabel)
        addSubview(randomMealsCollectionView)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10)
        randomMealsCollectionView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        randomMealsCollectionView.delegate = self
        randomMealsCollectionView.dataSource = self
    }
    
}

// MARK: Extensions

extension CategoriesHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomMealCell.identifier, for: indexPath) as? RandomMealCell else {
            return UICollectionViewCell()
        }
        
        viewModel.getRandomRecipe { [weak self] in
            guard let recipe = self?.viewModel.recipe else {
                return
            }
            
            cell.configureCell(with: recipe)
        }
        
        return cell
    }
    
}

extension CategoriesHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: 180, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
