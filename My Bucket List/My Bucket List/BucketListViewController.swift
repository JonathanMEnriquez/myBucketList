//
//  MainTableView.swift
//  My Bucket List
//
//  Created by user on 1/16/18.
//  Copyright © 2018 jon. All rights reserved.
//

import UIKit
import CoreData

class BucketListTableViewController: UITableViewController, AddWordViewControllerDelegate {
    
    var personalList = [BucketListWord]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return personalList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        
        cell.textLabel?.text = String(describing: indexPath.row + 1) + ".  " + personalList[indexPath.row].contents!
        return cell
    }
    // Delete once swiped
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = personalList[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        
        personalList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    // Clicked on cell makes it editable
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "editItemSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addItemSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addWordTableController = navigationController.topViewController as! AddWordViewController
            addWordTableController.delegate = self
            
            addWordTableController.myIndexPath = nil
        }
        else if segue.identifier == "editItemSegue" {
            
            let navigationController = segue.destination as! UINavigationController
            let addWordTableController = navigationController.topViewController as! AddWordViewController
            addWordTableController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let word = personalList[indexPath.row]
            addWordTableController.word = word.contents!
            let instruction = "Want to edit this entry?"
            addWordTableController.instructions = instruction
            addWordTableController.myIndexPath = indexPath
        }
    }
    
    func fetchAllItems() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListWord")
        do {
            let result = try managedObjectContext.fetch(request)
            personalList = result as! [BucketListWord]
        } catch {
            print(error)
        }
    }
    
    // MARK: App Delegate Methods
    
    func cancelButtonPressed(by: AddWordViewController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func addWord(by: AddWordViewController, wordToAdd: String, whereToAdd: NSIndexPath?) {
        
        if let ip = whereToAdd {
            let word = personalList[ip.row]
            word.contents = wordToAdd
        }
        
        else {
            let word = NSEntityDescription.insertNewObject(forEntityName: "BucketListWord", into: managedObjectContext) as! BucketListWord
            word.contents = wordToAdd
            personalList.append(word)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("During the run of the addWord function, this: ", error)
        }

        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
