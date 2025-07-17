//
//  DeleteAlertVC.swift
//  EF25NavigationApp
//
//  Created by iKame Elite Fresher 2025 on 30/6/25.
//

import UIKit

class DeleteAlertVC: UIViewController {
    var yesAction: (() -> Void)?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var outterStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outterStack.layer.cornerRadius = 15
        outterStack.isLayoutMarginsRelativeArrangement = true
        outterStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        yesBtn.layer.cornerRadius = 15
        cancelBtn.layer.cornerRadius = 15
        cancelBtn.layer.borderWidth = 1.5
        cancelBtn.layer.borderColor = UIColor.primary1.cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func yesTapped(_ sender: UIButton) {
        dismiss(animated: true)
        yesAction?()
    
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
