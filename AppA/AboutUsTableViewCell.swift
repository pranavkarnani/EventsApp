//
//  AboutUsTableViewCell.swift
//  App-A-Thon
//
//  Created by Pranav Karnani on 15/03/18.
//  Copyright © 2018 Pranav Karnani. All rights reserved.
//

import UIKit

class AboutUsTableViewCell: UITableViewCell {

    @IBOutlet weak var sponsorImage: UIImageView!
    @IBOutlet weak var sponsorName: UILabel!
    @IBOutlet weak var Cellview: UIView!
    @IBOutlet weak var descript: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
