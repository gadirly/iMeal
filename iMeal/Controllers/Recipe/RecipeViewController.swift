//
//  RecipeViewController.swift
//  iMeal
//
//  Created by Babek Gadirli on 07.10.23.
//

import UIKit
import TagListView

class RecipeViewController: UIViewController {
    // MARK: Properties
    
    var mealTags = [String]()

    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
        
    private let mainImageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let tagListView: TagListView = {
        var view = TagListView()
        view.alignment = .leading
        view.textFont = UIFont.boldSystemFont(ofSize: 16)
        view.tagBackgroundColor = .systemGreen
        view.cornerRadius = 9
        return view
    }()
    
    private let recipeName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let recipeText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HalveticaNeue", size: 17)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    
    
    // MARK: Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        
        navigationController?.navigationBar.isTranslucent = true
        
        

        
        view.addSubview(scrollView)
        
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        
        
        scrollView.addSubview(mainImageView)
        scrollView.addSubview(recipeName)
        scrollView.addSubview(recipeText)
        
        
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        configureTagView()

        
        recipeName.anchor(top: tagListView.bottomAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 20)
        
        recipeText.anchor(top: recipeName.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        
        
        if let navigationController = self.navigationController {
            let navigationBarHeight = navigationController.navigationBar.frame.size.height
            scrollView.contentInset = UIEdgeInsets(top: -2.7*navigationBarHeight, left: 0, bottom: 0, right: 0)
        }
        
    }
    
    func configureTagView() {
        scrollView.addSubview(tagListView)
        
        tagListView.anchor(top: mainImageView.bottomAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        tagListView.addTags(mealTags)
        
        
    }
    
    func configureTags() {
        
        scrollView.addSubview(stackView)
        stackView.distribution = .fillProportionally // or .fillProportionally

        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 30)

        ])
        
        stackView.anchor(top: mainImageView.bottomAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16)
        


        for tagText in mealTags {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = tagText
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = UIColor.white
            label.backgroundColor = UIColor.systemGreen // Set your desired background color
            label.layer.cornerRadius = 8 // Set the corner radius for rounded corners
            label.clipsToBounds = true // Ensure the corners are rounded
            label.textAlignment = .center // Center the text within the label
     
            stackView.addArrangedSubview(label)
        }
        
        
            
    }
    
    public func configureView(with recipeModel: Recipe) {
        recipeName.text = recipeModel.strMeal
        recipeText.text = recipeModel.strInstructions
        
        if let tags = recipeModel.tags {
            mealTags = tags
        }
        
        print(recipeModel.strTags ?? "Empty")
        guard let imageUrl = URL(string: recipeModel.strMealThumb) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.mainImageView.sd_setImage(with: imageUrl)

        }
    }
    
    // MARK: Actions
    
}
