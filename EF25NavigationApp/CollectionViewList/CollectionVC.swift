////
////  CollectionVC.swift
////  EF25NavigationApp
////
////  Created by iKame Elite Fresher 2025 on 30/6/25.
////
//
//import UIKit
//
//extension CollectionVC: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return sectionHeader.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let key = sectionHeader[section]
//        return groupedData[key]?.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let key = sectionHeader[indexPath.section]
////        let profilesInSection = groupedData[key]?.sorted { $0.firstName < $1.firstName } ?? []
////        let profile = profilesInSection[indexPath.item]
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
//        cell.configure(with: data[indexPath.item])
////        cell.profileButton.tag = indexPath.row
////        cell.profileButton.addTarget(self, action: #selector(profileButtonTapped(_:)), for: .touchUpInside)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 50)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeader", for: indexPath) as! CollectionHeader
//        header.titleLabel.text = String(sectionHeader[indexPath.section])
////        reusableview.titleLabel.text = "aaa"
//        return header
//    }
//}
//
//extension CollectionVC: UICollectionViewDelegate {
//    
//}
//
//extension CollectionVC: ResultDelegate {
//    func update(_ profile: Profile) {
//        data.append(profile)
//        collectionView.reloadData()
//        updateBackgroundView()
//        updateNavigationBar()
//    }
//    
//    
//}
//class CollectionVC: UIViewController {
//    var data: [Profile] = []
//    var groupedData: [Character: [Profile]] = [:]
//    var sectionHeader: [Character] = []
//    func orgarizeData() {
//        groupedData = Dictionary(grouping: data) { $0.firstName.first! }
//        sectionHeader = groupedData.keys.sorted()
//    }
//    
//    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var addProfileButton: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "List"
//        
//        collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
//        collectionView.register(UINib(nibName: "CollectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeader")
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        
//        updateBackgroundView()
//        setupButton()
//        // Do any additional setup after loading the view.
//    }
//    
//    func setupButton() {
//        addProfileButton.layer.cornerRadius = 15
//        addProfileButton.layer.masksToBounds = true
//        addProfileButton.tintColor = .neutral5
//        addProfileButton.backgroundColor = .primary1
//    }
//    
//    @IBAction func addProfileButtonTapped() {
//        let vc = InformationVC()
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    func updateBackgroundView() {
//        if data.isEmpty {
//            let emptyView = UIView(frame: collectionView.bounds)
//            let imageView = UIImageView(image: UIImage.emptyBox1)
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            let label = UILabel()
//            label.text = "Empty folder, Tap \"Add Profile\" to create profile now."
//            label.numberOfLines = 0
//            label.textColor = .neutral15
//            label.textAlignment = .center
//            label.translatesAutoresizingMaskIntoConstraints = false
//            
//            let text = NSMutableAttributedString(string: label.text!)
//            if let range = text.string.range(of: "\"Add Profile\"") {
//                let nsRange = NSRange(range, in: label.text!)
//                text.addAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .semibold), .foregroundColor: UIColor.primary1], range: nsRange)
//            }
////            text.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .regular), range: NSRange(location: 0, length: text.string.count))
//            label.attributedText = text
//            
//            emptyView.addSubview(imageView)
//            emptyView.addSubview(label)
//            
//            NSLayoutConstraint.activate([
//                imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
//                imageView.centerYAnchor.constraint(equalTo: emptyView.topAnchor, constant: 300),
////                imageView.topAnchor.constraint(equalTo: label.topAnchor, constant: 16),
//                imageView.widthAnchor.constraint(equalToConstant: 128),
//                imageView.heightAnchor.constraint(equalToConstant: 128),
//                
//                label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
////                label.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: 0),
//                label.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 0),
//                label.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: 0)
//            ])
//            addProfileButton.isHidden = false
//            collectionView.backgroundView = emptyView
//        } else {
//            collectionView.backgroundView = nil
//            addProfileButton.isHidden = true
//        }
//    }
//    
//    func updateNavigationBar() {
//        if !data.isEmpty {
//            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(addProfileIconTapped))
//            navigationItem.rightBarButtonItem?.tintColor = .primary1
//        } else {
//            navigationItem.rightBarButtonItem = nil
//        }
//    }
//    
//    @objc func addProfileIconTapped() {
//        let vc = InformationVC()
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
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
