//
//  Checklist.swift
//  ToDoList
//
//  Created by Macbook Pro on 2/4/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit 

class Checklist: NSObject, NSCoding {
    
    var name = ""
    var checked = true 
    var items = [ChecklistItem]()
    var iconName:String
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
      name = aDecoder.decodeObject(forKey: "Name") as! String
      items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
      iconName = aDecoder.decodeObject(forKey: "IconName") as! String
      super.init() 
    }
    
    func encode(with aCoder: NSCoder) {
      aCoder.encode(name, forKey: "Name")
      aCoder.encode(items, forKey: "Items")
      aCoder.encode(iconName, forKey: "IconName")
    }
    
    func toggleCheckedState() {
        checked = !checked
    }
 }
