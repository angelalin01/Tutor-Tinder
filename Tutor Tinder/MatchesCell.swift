//
//  MatchesCell.swift
//  Tutor Tinder
//
//  Created by Angela Lin on 4/24/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import UIKit

class MatchesCell: UITableViewCell {
    
    @IBOutlet weak var matchesImage: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var contactInfo: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
