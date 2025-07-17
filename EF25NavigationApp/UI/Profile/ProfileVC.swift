//
//  ProfileVC.swift
//  EF25NavigationApp
//
//  Created by iKame Elite Fresher 2025 on 24/6/25.
//

import UIKit
import Combine

protocol ProfileDelegate: AnyObject {
    func edit(_ profile: Profile, index: Int)
    func delete(at index: Int)
}

class ProfileVC: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var yourBMILabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var infoStack: UIStackView!
    
    private var profile: Profile
    private var subscription: Set<AnyCancellable> = .init()
   
    init(profile: Profile) {
        self.profile = profile
        super.init(nibName: "ProfileVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        setupUI()
        updateUI()
        setupDeleteButton()
        configProfile()
        observer()
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        let vc = InformationVC(profile: profile)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupDeleteButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteButton))
        navigationItem.rightBarButtonItem?.tintColor = .primary1
    }
    
    private func setupUI() {
        stack.layer.cornerRadius = 15
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        editButton.backgroundColor = .primary1
        editButton.layer.cornerRadius = 15
        
        nameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func updateUI() {
        nameLabel.text = profile.fullName
        weightLabel.text = "\(Int(profile.weight)) kg"
        heightLabel.text = "\(Int(profile.height)) cm"
        sexLabel.text = profile.gender
        bmiLabel.text = String(format: "%.1f", profile.bmi)
    }
    
    private func observer() {
        ProfileManager
            .shared
            .onUpdateAction
        //                .filter({
        //                    switch $0 {
        //                    case .update(_, let updatedProfile):
        //                        return self.profile.id == updatedProfile.id
        //                    case .delete(let id):
        //                        return false
        //                    default:
        //                        return false
        //                    }
        //                })
            .compactMap({
                switch $0 {
                case .update(_, let profile):
                    return profile
                default:
                    return nil
                }
            })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedProfile in
                self?.profile = updatedProfile
                self?.updateUI()
            }
            .store(in: &subscription)
    }
    
    @objc func deleteButton() {
        let alert = DeleteAlertVC()
        alert.yesAction = { [weak self] in
            guard let self else { return }
            ProfileManager.shared.onActionPassthroughSubject.send(.delete(self.profile.id))
            self.navigationController?.popViewController(animated: true)
        }

        present(alert, animated: true)

    }

    
    func configProfile() {
        nameLabel.text = profile.fullName
        weightLabel.text = "\(Int(profile.weight)) kg"
        heightLabel.text = "\(Int(profile.height)) cm"
        sexLabel.text = profile.gender
        bmiLabel.text = String(format: "%.1f", profile.bmi)
    }
    
    
}
