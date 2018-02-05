//
//  AddOrEditChecklistViewController.swift
//  ToDoList
//
//  Created by Macbook Pro on 2/5/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

protocol AddOrEditChecklistViewControllerDelegate: class {
  func AddOrEditChecklistViewController(_ controller: AddOrEditChecklistViewController )
  
  func AddOrEditChecklistViewController(_ controller: AddOrEditChecklistViewController,
                                didFinishAdding checklist: Checklist)
  
  func AddOrEditChecklistViewController(_ controller: AddOrEditChecklistViewController,
                                didFinishEditing checklist: Checklist)
}

class AddOrEditChecklistViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddOrEditChecklistViewControllerDelegate?
    
    var checklistToEdit: Checklist?
    
    
    
}
