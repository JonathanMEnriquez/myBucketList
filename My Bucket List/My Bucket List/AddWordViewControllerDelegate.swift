//
//  AddWordViewControllerDelegate.swift
//  My Bucket List
//
//  Created by user on 1/16/18.
//  Copyright © 2018 jon. All rights reserved.
//

import Foundation

protocol AddWordViewControllerDelegate: class {
    
    func addWord(by controller: AddWordViewController, wordToAdd: String, whereToAdd: NSIndexPath?)
    
    func cancelButtonPressed(by controller: AddWordViewController)
}
