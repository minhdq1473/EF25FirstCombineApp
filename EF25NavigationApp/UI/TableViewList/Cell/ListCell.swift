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
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupUI() {
        stackView.backgroundColor = .neutral5
        stackView.layer.cornerRadius = 20
        stackView.layer.masksToBounds = false
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = #colorLiteral(red: 0.8705882353, green: 0.8745098039, blue: 0.9019607843, alpha: 1)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
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
