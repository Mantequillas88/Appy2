//
//  JournalEntryViewController.swift
//  Appy2
//
//  Created by Amber Craig on 23/02/2023.
//

import Foundation
import UIKit
import CoreData

class JournalEntryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var journalTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var journalViewController : JournalViewController?
        
    var journalEntry : JournalEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        dateLabel.text = Date.now.formatted(.dateTime.day().year().month(.abbreviated))
                
        if journalEntry == nil {
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                journalEntry = JournalEntry(context: context)
                journalEntry?.date = datePicker.date
                journalEntry?.entry = journalTextView.text
                journalTextView.becomeFirstResponder()
                }
            }
        
        journalTextView.text = journalEntry?.entry
        if let dateToBeDisplayed = journalEntry?.date {
        datePicker.date = dateToBeDisplayed
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = " \(formatter.string(from: datePicker.date))"
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        journalTextView.delegate = self

        
    }
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        journalEntry?.date = sender.date
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = " \(formatter.string(from: sender.date))"
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    

//    @IBAction func binButtonPressed(_ sender: UIButton) {
//
//        if journalEntry != nil {
//            if let context = nsContext {
//                context.delete(journalEntry!)
//                try? context.save()
//            }
//            navigationController?.popViewController(animated: true)
//        }
//    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        journalEntry?.entry = journalTextView.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            NotificationCenter.default.post(name: Notification.Name("Journal Entry Saved"), object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            bottomConstraint.constant = keyboardHeight
        }
    }
}
