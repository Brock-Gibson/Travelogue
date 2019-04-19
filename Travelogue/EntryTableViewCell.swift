//
//  EntryTableViewCell.swift
//  Travelogue
//
//  Created by Brock Gibson on 4/19/19.
//  Copyright © 2019 Brock Gibson. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var entryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
