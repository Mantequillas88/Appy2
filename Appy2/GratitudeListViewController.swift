//
//  GratitudeListViewController.swift
//  Appy2
//
//  Created by Amber Craig on 23/02/2023.
//

import UIKit
import CoreData

class GratitudeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var gratitudeListTableView: UITableView!
    
    var nsContext: NSManagedObjectContext!
    
    var gratitudeEntries: [GratitudeListEntry] = []
    
    var gratitudeEntry = [GratitudeListEntry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gratitudeListTableView.dataSource = self
        gratitudeListTableView.delegate = self
        
        nsContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    }
    
    @objc func updateGratitudeListData() {
        if let context = nsContext {
            
            // sort entries in order of most recent to oldest
            let request: NSFetchRequest<GratitudeListEntry> = GratitudeListEntry.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            
            //fetch data from coreData
            if let dataFromCoreData = try? context.fetch(request) as [GratitudeListEntry] {
                
                gratitudeEntries = dataFromCoreData
                gratitudeListTableView?.reloadData()

            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateGratitudeListData), name:     Notification.Name("Gratitude Entry Saved"), object: nil)
        
        updateGratitudeListData()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return gratitudeEntries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let row = tableView.dequeueReusableCell(withIdentifier: "gratitudeCell") as? GratitudeTableViewCell {
            
            let gratitudeEntry = gratitudeEntries[indexPath.row]

            row.entryTag.text = gratitudeEntry.entry
            row.monthTag.text = gratitudeEntry.setMonth()
            row.dayTag.text = gratitudeEntry.setDay()
            
//            set highlight colour of cell when clicked
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            row.selectedBackgroundView = backgroundView
            
            return row
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let gratitudeEntry = gratitudeEntries[indexPath.row]
        
        if editingStyle == .delete {
            
            nsContext.delete(gratitudeEntry)
            do {
                    try nsContext.save()
                } catch let error as NSError {
                    print("Error While Deleting Note: \(error.userInfo)")
                }
            }
        updateGratitudeListData()
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65

    }
    
}
