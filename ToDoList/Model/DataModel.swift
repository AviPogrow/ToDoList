//
//  DataModel.swift
//  ToDoList
//
//  Created by Macbook Pro on 2/9/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import Foundation

//Define  the new DataModel object
//It will take over responsiblilites for loading and saving the to do lists
// from the AllListsViewController
class DataModel {
    
    //give it a checklists property to hold array of [Checklist]
    var checklists = [Checklist]()
    
    //make sure that as soon as dataModel object is created, it will attempt to
    //load checklist.plist
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    func registerDefaults() {
        
        //create a new dictionary instance and adds the value -1 for the key "Checklistindex"
        let dictionary: [String: Any] = ["ChecklistIndex": -1,
                                         "FirstTime": true]
        
        //store the dictionary in the UserDefaults object
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checklist = Checklist(name: "List")
            checklists.append(checklist)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
        
    }
    
    var indexOfSelectedChecklist: Int {
        get {
          return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
            
        }
    }
    
    
    //MARK - Persistance
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklist.plist")
    }
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(checklists, forKey: "Checklists")
        
        archiver.finishEncoding()
            data.write(to: dataFilePath(), atomically: true)
     }
    
    // this method is now called loadChecklists()
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        // this line is different from before
        checklists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
        unarchiver.finishDecoding()
      }
        
    }
}
