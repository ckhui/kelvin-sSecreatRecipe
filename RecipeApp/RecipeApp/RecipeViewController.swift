//
//  RecipeViewController.swift
//  RecipeApp
//
//  Created by NEXTAcademy on 12/23/16.
//  Copyright © 2016 NEXTAcademy. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, NewRecipeProtocol {
    
    lazy var sortLabel: UILabel = {
        let label = UILabel()
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleFilter))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SORT BY"
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.backgroundColor = UIColor.white
        label.addGestureRecognizer(tapGestureRecognizer)
        return label
    }()

    
    lazy var recipeTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        
        tv.register(RecipeTableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.backgroundColor = UIColor.white
        pv.dataSource = self
        pv.delegate = self
        return pv
    }()
    
    
    // you forgot your XML Parser
    let categories = ["All", "Vegetarian", "Fast Food", "Healthy", "No-Cook", "Make Ahead"]
    
    
    var arrayOfRecipe = [Recipe]()
    var filterArrayOfRecipe = [Recipe]()
    var selectedRow : Int?
    var categoriesChosed = "All" // just pass the object at categories
    // var selectedCategory = categories[0] // in this case it will be "All"
    var navigationBarHeight: CGFloat = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(handleAddRecipe))
        navigationBarHeight = self.navigationController!.navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
        view.addSubview(sortLabel)
        view.addSubview(recipeTableView)
        view.addSubview(pickerView)
        pickerView.isHidden = true
        
        setupSortLabel()
        setupRecipeTableView()
        setupPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        recipeTableView.reloadData()
    }
    
    func getInfoOfNewRecipe(recipe: Recipe) {
        arrayOfRecipe.append(recipe)
    }
    
    func handleAddRecipe() {
        let nextController = AddRecipeViewController()
        nextController.delegate = self
        let navController = UINavigationController(rootViewController: nextController)
        self.present(navController, animated: true, completion: nil)
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
    
    func setupSortLabel() {
        sortLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: navigationBarHeight).isActive = true
        sortLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sortLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        sortLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupRecipeTableView() {
        recipeTableView.topAnchor.constraint(equalTo: sortLabel.bottomAnchor).isActive = true
        recipeTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        recipeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        recipeTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupPickerView() {
        pickerView.topAnchor.constraint(equalTo: sortLabel.bottomAnchor).isActive = true
        pickerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pickerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: self.view.frame.height - UIApplication.shared.statusBarFrame.height - sortLabel.frame.height).isActive = true
    }

}


extension RecipeViewController: UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
}

extension RecipeViewController: UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let category = categories[row]
        
        // if you are using Swift, use switch instead of if else
        if category == "All" {
            filterArrayOfRecipe = []
            categoriesChosed = category
        } else {
            filterArrayOfRecipe = [] // there is no need to empty this array
            filterArrayOfRecipe = arrayOfRecipe.filter{$0.type == category} // assigning a new value will replace the previous value
            categoriesChosed = category
        }
        
        // basically your if else method is actually redundant
        // here is how i prefer to solve it
        if category == "All" {
            filterArrayOfRecipe = arrayOfRecipe
        } else {
            filterArrayOfRecipe = arrayOfRecipe.filter{$0.type == category}
        }
        categoriesChosed = category
        // above can also be moved to a function
        // check below
        
        recipeTableView.reloadData()
    }
    
    
}

extension RecipeViewController {
    func recipes(type: String = "All") -> [Recipe] {
        if type != "All" {
            return arrayOfRecipe.filter{ $0.type == type }
        }
        return arrayOfRecipe
    }
}


extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // if you follow my changes you can just use filterArrayOfRecipe instead and there is no need to call if-else statement
        if filterArrayOfRecipe.count == 0 && (categoriesChosed == "All" || sortLabel.text == "SORT BY") {
            return arrayOfRecipe.count
        } else {
            return filterArrayOfRecipe.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeTableViewCell
        
        let food : Recipe
        
        
        // if you follow my changes you can just use filterArrayOfRecipe instead and there is no need to call if-else statement
        if filterArrayOfRecipe.count == 0 {
            food = arrayOfRecipe[indexPath.row]
        } else {
            food = filterArrayOfRecipe[indexPath.row]
        }
        
        cell.textLabel?.text = food.name
        cell.detailTextLabel?.text = food.ingredients

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        self.moveToRecipeDetailViewController()
    }
    
    func moveToRecipeDetailViewController() {
        let nextController = RecipeDetailViewController()
        
        // if you follow my changes you can just use filterArrayOfRecipe instead and there is no need to call if-else statement
        if filterArrayOfRecipe.count == 0 {
            nextController.food = arrayOfRecipe[self.selectedRow!]
        } else {
            nextController.food = filterArrayOfRecipe[self.selectedRow!]
        }
        
        let navController = UINavigationController(rootViewController: nextController)
        self.present(navController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true  
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        // whenever you implement this delegate, make sure that you check editingStyle
        // because this delegate might get called if there is insertion too
        
        // if you follow my changes you can just use filterArrayOfRecipe instead and there is no need to call if-else statement
        if filterArrayOfRecipe.count == 0 {
            arrayOfRecipe.remove(at: indexPath.row)
        } else {
            let objectToDelete = filterArrayOfRecipe[indexPath.row]
            arrayOfRecipe = arrayOfRecipe.filter{ $0.name != objectToDelete.name }
            filterArrayOfRecipe.remove(at: indexPath.row)
        }
        
        recipeTableView.reloadData()
    }


    
}
