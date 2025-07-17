//
//  InformationVC.swift
//  EF25NavigationApp
//
//  Created by iKame Elite Fresher 2025 on 24/6/25.
//

import UIKit
import Combine

class InformationVC: UIViewController {
    @IBOutlet weak var view1: CustomView!
    @IBOutlet weak var view2: CustomView!
    @IBOutlet weak var view3: CustomView!
    @IBOutlet weak var view4: CustomView!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    
    private var firstNameSubject: CurrentValueSubject<String, Never> = .init("")
    private var lastNameSubject: CurrentValueSubject<String, Never> = .init("")
    private var weightSubject: CurrentValueSubject<String, Never> = .init("")
    private var heightSubject: CurrentValueSubject<String, Never> = .init("")
    private var genderSubject: CurrentValueSubject<String, Never> = .init("Male")
    
    private var subscriptions: Set<AnyCancellable> = .init()
    private let profile: Profile
    private let isNewProfile: Bool
    
    init(profile: Profile) {
        self.profile = profile
        self.isNewProfile = profile.firstName.isEmpty
        super.init(nibName: "InformationVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Information"
        setupTextField()
        setupButton()
        observer()
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let newProfile = Profile(
            id: isNewProfile ? UUID().uuidString : profile.id,
            firstName: firstNameSubject.value,
            lastName: lastNameSubject.value,
            gender: gender.selectedSegmentIndex == 0 ? "Male" : "Female",
            weight: Double(weightSubject.value) ?? 0,
            height: Double(heightSubject.value) ?? 0
        )
        if isNewProfile {
            ProfileManager.shared.onActionPassthroughSubject.send(.add(newProfile))
        } else {
            ProfileManager.shared.onActionPassthroughSubject.send(
                .edit(
                    id: profile.id,
                    firstName: newProfile.firstName,
                    lastName: newProfile.lastName,
                    gender: newProfile.gender,
                    weight: newProfile.weight,
                    height: newProfile.height
                )
            )
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func setupTextField() {
        view1.label.text = "First name"
        view1.text.placeholder = "Enter first name"
        view2.label.text = "Last name"
        view2.text.placeholder = "Enter last name"
        view3.label.text = "Weight"
        view3.text.placeholder = "Kg"
        view4.label.text = "Height"
        view4.text.placeholder = "Cm"
        
        view1.view.layer.cornerRadius = 15
        view2.view.layer.cornerRadius = 15
        view3.view.layer.cornerRadius = 15
        view4.view.layer.cornerRadius = 15
        
        view1.text.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        view2.text.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        view3.text.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        view4.text.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupButton() {
        saveButton.layer.cornerRadius = 15
        saveButton.backgroundColor = .neutral3
        saveButton.isEnabled = false
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case view1.text:
            firstNameSubject.send(textField.text ?? "")
        case view2.text:
            lastNameSubject.send(textField.text ?? "")
        case view3.text:
            weightSubject.send(textField.text ?? "")
        case view4.text:
            heightSubject.send(textField.text ?? "")
        default:
            break
        }
    }
    
    private func observer() {
        Publishers.CombineLatest4(
            firstNameSubject,
            lastNameSubject,
            weightSubject,
            heightSubject
        )
        .receive(on: DispatchQueue.main)
        .sink { [weak self] firstName, lastName, weight, height in
            let isWeightValid = Double(weight) != nil
            let isHeightValid = Double(height) != nil
            let isValid = !firstName.isEmpty && !lastName.isEmpty && isWeightValid && isHeightValid
            
            self?.saveButton.isEnabled = isValid
            self?.saveButton.backgroundColor = isValid ? .primary1 : .neutral3
        }
        .store(in: &subscriptions)
        
        if !isNewProfile {
            firstNameSubject.send(profile.firstName)
            lastNameSubject.send(profile.lastName)
            weightSubject.send(String(profile.weight))
            heightSubject.send(String(profile.height))
            
            view1.text.text = profile.firstName
            view2.text.text = profile.lastName
            view3.text.text = String(profile.weight)
            view4.text.text = String(profile.height)
            gender.selectedSegmentIndex = profile.gender == "Male" ? 0 : 1
        }
    }
}
