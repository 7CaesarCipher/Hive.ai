//
//  wikipediaTableViewCell.swift
//  Hive.ai
//
//  Created by shashank Mishra on 04/01/24.
//

import UIKit

class wikipediaTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: CustomImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productSubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
