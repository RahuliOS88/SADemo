//
//  InspectionTableViewCell.swift
//  SADemo
//
//  Created by Rahul Gupta on 21/07/24.
//

import UIKit

class InspectionTableViewCell: UITableViewCell {

    @IBOutlet weak var inspectionIdLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(inspection: InspectionSA) {
        self.inspectionIdLbl.text = "Insepection Id: \(inspection.id)"
    }
}
