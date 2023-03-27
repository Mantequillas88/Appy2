//
//  GratitudeAddOrReadViewController.swift
//  Appy2
//
//  Created by Amber Craig on 01/03/2023.
//

import UIKit

class GratitudeAddOrReadViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var readButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //increase size of sfSymbol UIButton image
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let largeBoldCheckmark = UIImage(systemName: "plus.circle.fill", withConfiguration: largeConfig)
        let largeBoldBook = UIImage(systemName: "book.fill", withConfiguration: largeConfig)

        addButton.setImage(largeBoldCheckmark, for: .normal)
        readButton.setImage(largeBoldBook, for: .normal)
        
        //make view background dark transparent 
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        showAnimate()
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    //animate view to load in
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }

    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        })
    }
}
