//
//  AddWordViewController.swift
//  My Bucket List
//
//  Created by user on 1/16/18.
//  Copyright © 2018 jon. All rights reserved.
//

import UIKit

class AddWordViewController: UIViewController {

    var instructions: String = "What would you like to do?"
    var word: String?
    var myIndexPath: NSIndexPath?
    weak var delegate: AddWordViewControllerDelegate?
    
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var instructionsLabel: UILabel!
    
    @IBAction func cancelButtonisPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func saveButtonIsPressed(_ sender: UIBarButtonItem) {
        if let newItem = inputTextField.text {
            delegate?.addWord(by: self, wordToAdd: newItem, whereToAdd: myIndexPath)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionsLabel.text = instructions
        
        if word != nil {
            inputTextField.text = word
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
