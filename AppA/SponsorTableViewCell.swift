//
//  SponsorTableViewCell.swift
//  App-A-Thon
//
//  Created by Aritro Paul on 14/03/18.
//  Copyright © 2018 Pranav Karnani. All rights reserved.
//

import UIKit

class SponsorTableViewCell: UITableViewCell {

    @IBOutlet weak var sponsorName: UILabel!
    @IBOutlet weak var CellView: UIView!
    @IBOutlet weak var sponsorImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
