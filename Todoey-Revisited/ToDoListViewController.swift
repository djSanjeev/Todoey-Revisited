//
//  ViewController.swift
//  Todoey-Revisited
//
//  Created by Sanjeev Vyas on 08/07/19.
//  Copyright © 2019 Sanjeev Vyas. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
  var itemArray = [ "Find Mike" ,"Buy Eggos" ,"Destroy Demogorgon"]
    
    let defaults  = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    //MARK:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark  {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK : - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
      var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoe Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item:", style: .default) { (action) in
            //what will happen wen the user clicks add item button on our ALert
            
            
            
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print(alertTextField)
        }
        alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
    
}

