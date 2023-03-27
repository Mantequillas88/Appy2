//
//  GratitudeEntryViewController.swift
//  Appy2
//
//  Created by Amber Craig on 23/02/2023.
//

import UIKit
import CoreData

class GratitudeEntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var gratitudeTextField: UITextField!
    
    var gratitudeEntry : GratitudeListEntry?

    override func viewDidLoad() {
        super.viewDidLoad()

        }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                gratitudeEntry = GratitudeListEntry(context: context)
                gratitudeEntry?.date = Date.now
                gratitudeEntry?.entry = gratitudeTextField.text
                gratitudeTextField.becomeFirstResponder()
            }
        
        gratitudeTextField.text = gratitudeEntry?.entry

        gratitudeTextField.delegate = self
        
        gratitudeTextField.text = ""

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        NotificationCenter.default.post(name: Notification.Name("Gratitude Entry Saved"), object: nil)
    }
}
