//
//  ListCell.swift
//  EF25NavigationApp
//
//  Created by iKame Elite Fresher 2025 on 26/6/25.
//

import UIKit

//protocol CellDelegate: AnyObject {
//    func didTapProfileButton(in cell: ListCell)
//}

class ListCell: UITableViewCell {
//    weak var delegateCell: CellDelegate?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        
        contentView.backgroundColor = .neutral5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.stackView.frame = stackView.frame.inset(by: UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10))
//    }
//    @IBAction func profileButtonTapped(_ sender: UIButton) {
//        let vc = ProfileVC()
//        UINavigationController().pushViewController(vc, animated: true)
//    }
    
    func configCell(profile: Profile) {
        nameLabel.text = profile.fullName
        infoLabel.text = "W: \(Int(profile.weight)) kg  -  H: \(Int(profile.height)) cm"
    }
    
}
