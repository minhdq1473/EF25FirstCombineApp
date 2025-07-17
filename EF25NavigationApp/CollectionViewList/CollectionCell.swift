//
//  CollectionCell.swift
//  EF25NavigationApp
//
//  Created by iKame Elite Fresher 2025 on 30/6/25.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with profile: Profile) {
        nameLabel.text = profile.fullName
    }
    
    

}
