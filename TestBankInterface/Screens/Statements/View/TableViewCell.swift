//
//  TableViewCell.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 17/06/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var operationTypeLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var valueDateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
