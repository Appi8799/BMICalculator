//
//  CustomTableViewCell.swift
//  FinalTest_MAPD714_ApekshaParmar_301205325
//
//  Student Name: Apeksha Parmar
//  Student ID: 301205325
//
//  Created by Apeksha Parmar on 2022-12-16.
//

import UIKit


class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblBMIScore: UILabel!
    @IBOutlet weak var lblWE: UILabel!
    @IBOutlet weak var lblHE: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
