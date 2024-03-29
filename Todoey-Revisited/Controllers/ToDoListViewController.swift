//
//  ViewController.swift
//  Todoey-Revisited
//
//  Created by Sanjeev Vyas on 08/07/19.
//  Copyright © 2019 Sanjeev Vyas. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
  var itemArray = [Item]()
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
   override func viewDidLoad() {
        super.viewDidLoad()
       
   print(dataFilePath)
        loadItems()
     }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
    //Ternary Operator
    cell.accessoryType = item.done ? .checkmark: .none
   
        return cell
    }
 
    //MARK:- TableView Delegate Methods
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done

  saveItems()
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK : - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
      
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item:", style: .default) {(action) in
            
            //what will happen wen the user clicks add item button on our ALert
            let newItem  = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
           
         self.saveItems()
            
        }
   
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print(alertTextField)
        }
       
        alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
    
// MARK: - Model Manupulation Methods
    
    func saveItems(){

        let encoder = PropertyListEncoder()

 do {
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        } catch{
            print("Error encoding item Array,\(error)")
        }

        tableView.reloadData()

    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
                } catch {
                    print("Error Decoding item Array,\(error)")
                }
             
            }
        }
    }



