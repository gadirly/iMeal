//
//  HomeViewController.swift
//  iMeal
//
//  Created by Babek Gadirli on 02.10.23.
//

import UIKit
import ViewAnimator

enum MainSections: Int {
    case Beef = 0
    case SeaFoods = 1
    case desserts = 2
    case alcogolicDrinks = 3
}

class HomeViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel = HomeViewModel()
    
    private let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
                
        collectionView.register(MainCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainCollectionViewHeader.identifier)
        
        
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let sectionTitles: [String] = [
            "Meals by category 😍",
            "Sea Foods 🐟",
            "Desserts 🧁",
            "Alchoholic Drinks 🍷"
        ]

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavbar()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let animation = AnimationType.from(direction: .right, offset: 50)
//        UIView.animate(views: mainCollectionView.visibleCells, animations: [animation])
//        UIView.animate(views: mainCollectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader), animations: [animation])
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainCollectionView.frame = view.bounds
    }
    
    
    // MARK: Actions
    
    
    // MARK: Helpers
    
 

    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(mainCollectionView)
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        
        
    }
    
    private func configureNavbar() {
        
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
    
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = .white
        
            
        }


}

// MARK: Extensions



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as? CategoriesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        cell.resetData()

        
        switch indexPath.section{
        case MainSections.Beef.rawValue:
            
            viewModel.getBeefFoods { [weak self] in
                guard let result = self?.viewModel.beefFoodList else {
                    return
                }
                
                cell.cofigureCellWithMeals(with: result)
                
                
                
            }
            
            
        case MainSections.SeaFoods.rawValue:
            
            viewModel.getSeaFoods { [weak self] in
                guard let result = self?.viewModel.seaFoodList else {
                    return
                }
                
                cell.cofigureCellWithMeals(with: result)
            }
            
        case MainSections.desserts.rawValue:
            
            
            viewModel.getDesserts { [weak self] in
                guard let result = self?.viewModel.dessertsList else {
                    return
                }
                
                cell.cofigureCellWithMeals(with: result)
                cell.itemSize = CGSize(width: 180, height: 180)
            }
            
            
        case MainSections.alcogolicDrinks.rawValue:
            viewModel.getAlcoholicDrinks { [weak self] in
                guard let result = self?.viewModel.alcoholicDrinks else {
                    return
                }
                
                cell.cofigureCellWithMeals(with: result)
            }
            
        default:
            return UICollectionViewCell()
        }
        
        
        
        
        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainCollectionViewHeader.identifier, for: indexPath) as? MainCollectionViewHeader else {
            return UICollectionReusableView()
        }
        
        headerView.setText(text: sectionTitles[indexPath.section])
        return headerView
    }
    

    
   
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width)
        
        if indexPath.section == MainSections.desserts.rawValue {
            return CGSize(width: width, height: 180)
        } else {
            return CGSize(width: width, height: 130)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 40)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Add space (adjust the values as needed)
        return UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }
}

extension HomeViewController: CategoriesCollectionViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CategoriesCollectionViewCell, model: MealItemsProtocol) {
        
            
            viewModel.getRecipe(withID: model.id) { [weak self] in
                
                guard let strongSelf = self else {
                    return
                }

                guard let recipeModel = strongSelf.viewModel.recipe else {
                    return
                }
                
                DispatchQueue.main.async {
                    let vc = RecipeViewController()

                    vc.configureView(with: recipeModel)
                    strongSelf.navigationController?.pushViewController(vc, animated: true)
                }
                
                
            }
        
    }
    
    
}
