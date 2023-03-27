//
//  GratitudeTableViewCell.swift
//  Appy2
//
//  Created by Amber Craig on 23/02/2023.
//

import UIKit

class GratitudeTableViewCell: UITableViewCell {

    @IBOutlet weak var dayTag: UILabel!
    @IBOutlet weak var monthTag: UILabel!
    @IBOutlet weak var entryTag: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
