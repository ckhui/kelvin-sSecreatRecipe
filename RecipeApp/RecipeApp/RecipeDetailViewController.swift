//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by NEXTAcademy on 12/23/16.
//  Copyright © 2016 NEXTAcademy. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

   
    
    let viewContainer: UIView = {
        let vc = UIView()
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.layer.cornerRadius = 4
        vc.clipsToBounds = true
        vc.backgroundColor = UIColor.white
        return vc
    }()
    
    
    let foodNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    let stepLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()

    
    
    var navigationBarHeight: CGFloat = 0
    var food : Recipe? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(handleBack))
        navigationBarHeight = self.navigationController!.navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
        navigationItem.title = food?.type
        foodNameLabel.text = food?.name
        ingredientsLabel.text = food?.ingredients
        stepLabel.text = food?.step
        
        view.addSubview(viewContainer)
        view.addSubview(foodNameLabel)
        view.addSubview(ingredientsLabel)
        view.addSubview(stepLabel)
        
        setupViewContainer()
        setupFoodNameLabel()
        setupIngredientsLabel()
        setupStepsLabel()
    }
    
    
    func handleBack() {
        
        // try not to let viewController dismiss itself
        // use delegate instead
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupViewContainer() {
        viewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: navigationBarHeight + 30).isActive = true
        viewContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        viewContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        viewContainer.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
    }
    
    
    func setupFoodNameLabel() {
        foodNameLabel.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 12).isActive = true
        foodNameLabel.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 16).isActive = true
        foodNameLabel.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, constant: -32).isActive = true
        foodNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupIngredientsLabel() {
        ingredientsLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 4).isActive = true
        ingredientsLabel.leftAnchor.constraint(equalTo: foodNameLabel.leftAnchor).isActive = true
        ingredientsLabel.widthAnchor.constraint(equalTo: foodNameLabel.widthAnchor).isActive = true
    }
    
    func setupStepsLabel(){
        stepLabel.topAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: 15).isActive = true
        stepLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor).isActive = true
        stepLabel.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor).isActive = true
        
    }

}
