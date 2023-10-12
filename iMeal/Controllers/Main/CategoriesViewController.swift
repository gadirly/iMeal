//
//  CategoriesViewController.swift
//  iMeal
//
//  Created by Babek Gadirli on 11.10.23.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel = HomeViewModel()
    
    private let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.register(CategoriesHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoriesHeaderView.identifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "EmptyCellIdentifier")
        
        return collectionView
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchCategories()
    }
    
    // MARK: Helpers
    
    func configureUI() {
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .white
        view.addSubview(mainCollectionView)
        mainCollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
    
    private func fetchCategories() {
        viewModel.getCategories {
            DispatchQueue.main.async { [weak self] in
                self?.mainCollectionView.reloadData()
            }
        }
    }

}

// MARK: Extensions

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 1 {
            return viewModel.categories.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
                return UICollectionViewCell()
            }
            
            
            DispatchQueue.main.async { [weak self] in
                
                guard let category = self?.viewModel.categories[indexPath.row] else {
                    return 
                }
                        
                cell.configureCell(with: category)

            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCellIdentifier", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 0:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoriesHeaderView.identifier, for: indexPath) as? CategoriesHeaderView else {
                return UICollectionReusableView()
            }
            
            
            return headerView
        case 1:
            guard let headerView2 = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else {
                return UICollectionReusableView()
            }
            return headerView2
        default:
            return UICollectionReusableView()
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SearchResultsViewController()
        
        
    }
    
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width

        switch section {
        case 0:
            return CGSize(width: width, height: 290)
        case 1:
            return CGSize(width: width, height: 45)
        default:
            return CGSize(width: width, height: 30)

        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-20, height: 340)
    }
    
    
   
}
