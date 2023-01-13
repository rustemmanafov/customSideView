//
//  SideTableViewCell.swift
//  customSideView
//
//  Created by Rustem Manafov on 13.01.23.
//

import UIKit

class SideTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor(red: 0.04, green: 0.56, blue: 0.85, alpha: 1.00)
        self.iconImageView.tintColor = .white
        self.titleLabel.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
