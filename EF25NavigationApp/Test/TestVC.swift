////
////  TestVC.swift
////  EF25NavigationApp
////
////  Created by iKame Elite Fresher 2025 on 25/6/25.
////
//
//import UIKit
//
//class TestVC: UIViewController {
//
//    @IBOutlet weak var view1: CustomView!
//    @IBOutlet weak var view2: CustomView!
//    @IBOutlet weak var view3: CustomView!
//    @IBOutlet weak var view4: CustomView!
//    @IBOutlet weak var gender: UISegmentedControl!
//    @IBOutlet weak var updateButton: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view1.view.layer.cornerRadius = 15
//        view2.view.layer.cornerRadius = 15
//        view3.view.layer.cornerRadius = 15
//        view4.view.layer.cornerRadius = 15
//        
//        view1.label.text = "First name"
//        view1.text.placeholder = "Enter first name"
//        view2.label.text = "Last name"
//        view2.text.placeholder = "Enter last name"
//        view3.label.text = "Weight"
//        view3.text.placeholder = "Kg"
//        view4.label.text = "Height"
//        view4.text.placeholder = "Cm"
//        
//        gender.setTitle(NSLocalizedString("Male", comment: ""), forSegmentAt: 0)
//        gender.setTitle(NSLocalizedString("Female", comment: ""), forSegmentAt: 1)
//        
//        updateButton.setTitle("Update", for: .normal)
//        updateButton.layer.cornerRadius = 25
//        updateButton.backgroundColor = .primary1
//        updateButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
//        updateButton.setTitleColor(.neutral5, for: .normal)	
////        updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
////        updateButton.frame = CGRect(x: 16, y: 308, width: 343, height: 56)
//        updateButton.translatesAutoresizingMaskIntoConstraints = false
//
//        
//        
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
