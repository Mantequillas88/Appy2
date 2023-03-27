//
//  JournalViewController.swift
//  Appy2
//
//  Created by Amber Craig on 23/02/2023.
//

import UIKit
import CoreData

class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var journalTableView: UITableView!
    
    var journalEntries: [JournalEntry] = []
    var nsContext: NSManagedObjectContext!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        journalTableView.delegate = self
        journalTableView.dataSource = self
        nsContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
    }
    
    @objc func updateJournalData() {
        if let context = nsContext {
            
            // sort entries in order of most recent to oldest
            let request: NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            
            //fetch data from coreData
            if let dataFromCoreData = try? context.fetch(request) as [JournalEntry] {
                
                journalEntries = dataFromCoreData
                journalTableView.reloadData()

            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateJournalData), name:     Notification.Name("Journal Entry Saved"), object: nil)
        
        updateJournalData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return journalEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
    

        if let row = tableView.dequeueReusableCell(withIdentifier: "journalCell") as? JournalTableViewCell {
            
            let journalEntry = journalEntries[indexPath.row]

            row.entryTag.text = journalEntry.entry
            row.monthTag.text = journalEntry.setMonth()
            row.dayTag.text = journalEntry.setDay()
            
            //set highlight colour of cell when clicked
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(named: "purpleColour")
            row.selectedBackgroundView = backgroundView
            
            return row
            
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let journalEntry = journalEntries[indexPath.row]
        performSegue(withIdentifier: "openEntrySegue", sender: journalEntry)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let journalEntry = journalEntries[indexPath.row]
        
        if editingStyle == .delete {
            
            nsContext.delete(journalEntry)
            do {
                    try nsContext.save()
                } catch let error as NSError {
                    print("Error While Deleting Note: \(error.userInfo)")
                }
            }
        updateJournalData()
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryViewController = segue.destination as? JournalEntryViewController {
            
            if let onEntrySubmit = sender as? JournalEntry {
                entryViewController.journalEntry = onEntrySubmit
            }
        }
    }
}
