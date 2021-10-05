//
//  CustomSchoolTableViewCell.swift
//  NJSchools
//
//  Created by Kinneret Kanik on 04/10/2021.
//

import UIKit

class CustomSchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var schoolRating: UILabel!
    @IBOutlet weak var schoolPhone: UILabel!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolTypeImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
