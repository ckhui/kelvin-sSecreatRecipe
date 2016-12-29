//
//  AddRecipeViewController.swift
//  RecipeApp
//
//  Created by NEXTAcademy on 12/23/16.
//  Copyright © 2016 NEXTAcademy. All rights reserved.
//

import UIKit

protocol NewRecipeProtocol {
    func getInfoOfNewRecipe(recipe : Recipe)
}

class AddRecipeViewController: UIViewController {
    
    lazy var sortLabel: UILabel = {
        let label = UILabel()
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleFilter))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CHOOSE CATEGORY"
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.backgroundColor = UIColor.white
        label.addGestureRecognizer(tapGestureRecognizer)
        return label
    }()
    
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.backgroundColor = UIColor.white
        pv.dataSource = self
        pv.delegate = self
        return pv
    }()
    
    let nameTextField : UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.lightGray
        tf.placeholder = "Type New Recipe Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let ingredientsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ingredients"
        return label
    }()
    
    let ingredientTextView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.lightGray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let stepsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Steps"
        return label
    }()
    
    
    let stepsTextView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.lightGray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    lazy var confirmButton : UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.backgroundColor = (UIColor.blue).cgColor
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleConfirmAdd), for: .touchUpInside)
        return button
    }()
    
    let categories = ["Vegetarian", "Fast Food", "Healthy", "No-Cook", "Make Ahead"]
    var navigationBarHeight: CGFloat = 0
    var categoriesChosed = "Vegetarian"
    var delegate : NewRecipeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(handleBack))
        navigationBarHeight = self.navigationController!.navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
        
        view.addSubview(sortLabel)
        view.addSubview(nameTextField)
        view.addSubview(ingredientsLabel)
        view.addSubview(ingredientTextView)
        view.addSubview(stepsLabel)
        view.addSubview(stepsTextView)
        view.addSubview(confirmButton)
        view.addSubview(pickerView)
        pickerView.isHidden = true
        
        setupSortLabel()
        setupPickerView()
        setupNameTextField()
        setupConfirmButton()
        setupIngredintLabel()
        setupIngredientTextView()
        setupStepsTextView()
        setupStepsLabel()
    }
    
    func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    func handleFilter() {
        if pickerView.isHidden == true {
            sortLabel.text = "DONE"
            pickerView.isHidden = false
        } else {
            sortLabel.text = categoriesChosed
            pickerView.isHidden = true
        }
    }
    
    func handleConfirmAdd() {
        let newRecipe = Recipe()
        
        newRecipe.type = categoriesChosed
        newRecipe.name = nameTextField.text!
        newRecipe.ingredients = ingredientTextView.text
        newRecipe.step = stepsTextView.text
        delegate?.getInfoOfNewRecipe(recipe: newRecipe)
        
        dismiss(animated: true, completion: nil)
    }
    
    func setupSortLabel() {
        sortLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: navigationBarHeight).isActive = true
        sortLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sortLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
        sortLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupPickerView() {
        pickerView.topAnchor.constraint(equalTo: sortLabel.bottomAnchor).isActive = true
        pickerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pickerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: self.view.frame.height - UIApplication.shared.statusBarFrame.height - sortLabel.frame.height).isActive = true
    }
    
    func setupNameTextField() {
        nameTextField.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: 20).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: sortLabel.leadingAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: sortLabel.trailingAnchor).isActive = true
    }
    
    func setupIngredintLabel() {
        ingredientsLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25).isActive = true
        ingredientsLabel.leadingAnchor.constraint(equalTo: sortLabel.leadingAnchor).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: sortLabel.trailingAnchor).isActive = true

    }
    
    func setupIngredientTextView() {
        ingredientTextView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor).isActive = true
        ingredientTextView.leadingAnchor.constraint(equalTo: sortLabel.leadingAnchor).isActive = true
        ingredientTextView.trailingAnchor.constraint(equalTo: sortLabel.trailingAnchor).isActive = true
        ingredientTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupStepsLabel() {
        stepsLabel.topAnchor.constraint(equalTo: ingredientTextView.bottomAnchor, constant: 25).isActive = true
        stepsLabel.leadingAnchor.constraint(equalTo: sortLabel.leadingAnchor).isActive = true
        stepsLabel.trailingAnchor.constraint(equalTo: sortLabel.trailingAnchor).isActive = true

    }
    
    func setupStepsTextView() {
        stepsTextView.topAnchor.constraint(equalTo: stepsLabel.bottomAnchor).isActive = true
        stepsTextView.leadingAnchor.constraint(equalTo: sortLabel.leadingAnchor).isActive = true
        stepsTextView.trailingAnchor.constraint(equalTo: sortLabel.trailingAnchor).isActive = true
        stepsTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupConfirmButton() {
        confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }

}

extension AddRecipeViewController: UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
}

extension AddRecipeViewController: UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoriesChosed = categories[row]
    }
}
