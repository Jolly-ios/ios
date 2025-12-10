//
//  OrderCell.swift
//  TestApp
//
//  Created by Ahmad Rafiq on 21/09/2025.
//

import UIKit

class OrderCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: Order) {
        nameLabel.text = model.name
        priceLabel.text = "\(model.totalPrice)"
    }
    
}
