//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Julien Laurent on 12/4/20.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
   
    @IBOutlet weak var memeTableCellLabel: UILabel!
    @IBOutlet weak var memeTableCellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
