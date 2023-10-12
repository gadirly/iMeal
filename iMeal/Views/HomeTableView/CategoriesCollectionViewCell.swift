//
//  MainTableViewCell.swift
//  iMeal
//
//  Created by Babek Gadirli on 02.10.23.
//

import UIKit
import ViewAnimator

protocol CategoriesCollectionViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CategoriesCollectionViewCell, model: MealItemsProtocol)
}

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoriesCollectionViewCell"
    
    public var model: [MealItemsProtocol] = [MealItemsProtocol]()
    
    // MARK: Properties
    
    public var itemSize: CGSize?
    
    weak var delegate: CategoriesCollectionViewCellDelegate?
    
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 28
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MealCollectionViewCell.self, forCellWithReuseIdentifier: MealCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
 
        configureUI()
    }
    
    

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }
    
    // MARK: Action
    
    
    // MARK: Helpers
    
    private func configureUI() {
        contentView.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    public func resetData() {
        self.model.removeAll()

    }
    
    public func cofigureCellWithMeals(with meals: [MealItemsProtocol] ) {
        self.model = meals
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.collectionView.reloadData()
        }
    }
    
    public func animateCell() {
     
        let animation = AnimationType.from(direction: .right, offset: 300)
        UIView.animate(views: collectionView.visibleCells, animations: [animation])
    }
    

    
}

// MARK: Extensions

extension CategoriesCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCollectionViewCell.identifier, for: indexPath) as? MealCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = model[indexPath.row]
        
        
        cell.configureCell(with: item.imageURL, title: item.title)
        
        let animation = AnimationType.from(direction: .right, offset: 30)
        cell.animate(animations: [animation], duration: 0.25)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedModel = model[indexPath.row]
        delegate?.collectionViewTableViewCellDidTapCell(self, model: selectedModel)
    }
    
}

extension CategoriesCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let itemSize else {
            
            return CGSize(width: 180, height: 130)

        }
        return itemSize
    }
}
