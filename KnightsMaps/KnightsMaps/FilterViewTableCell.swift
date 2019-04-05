//
//  FilterViewTableCell.swift
//  KnightsMaps
//
//  Created by Michael Aoun on 3/11/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import UIKit

class FilterViewTableCell: UITableViewCell {

    
    @IBOutlet var button: UIButton!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    var cellDelegate: FilterViewCellDelegate?
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        cellDelegate?.didPressButton(sender.tag)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  

}

protocol FilterViewCellDelegate : class {
    func didPressButton(_ tag: Int)
}
