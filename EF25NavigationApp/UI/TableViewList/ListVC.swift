//
//  ListVC.swift
//  EF25NavigationApp
//
//  Created by iKame Elite Fresher 2025 on 26/6/25.
//

import UIKit
import Combine


class ListVC: UIViewController {
    @IBOutlet weak var tableList: UITableView!
    @IBOutlet weak var addProfileButton: UIButton!
    
    private var data: [Profile] = []
    private var subscriptions: Set<AnyCancellable> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"

        setupTableView()
        setupButton()
        updateBackgroundView()
        observer()  
    }
    
    @IBAction func addProfileButtonTapped() {
        let vc = InformationVC(profile: .init(firstName: "", lastName: "", gender: "", weight: 0, height: 0))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func observer() {
        ProfileManager
            .shared
            .onUpdateAction
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                self?.handleUpdateAction(action)
            }
            .store(in: &subscriptions)
    }
    
    private func handleUpdateAction(_ action: UpdateAction) {
        switch action {
        case .initial(let profiles):
            self.data = profiles
            updateBackgroundView()
            tableList.reloadData()
            
        case .update(let index, let profile):
            data[index] = profile
            tableList.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            
        case .delete(let index):
            data.remove(at: index)
            updateBackgroundView()
            tableList.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            
        case .add(let profile):
            data.append(profile)
            updateBackgroundView()
            tableList.insertRows(at: [IndexPath(row: data.count - 1, section: 0)], with: .automatic)
        }
    }
    
    private func setupTableView() {
        tableList.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        tableList.delegate = self
        tableList.dataSource = self
        tableList.separatorStyle = .none
//        tableList.allowsSelection = true 
    }
    
    private func setupButton() {
        addProfileButton.backgroundColor = .primary1
        addProfileButton.layer.cornerRadius = 15
        addProfileButton.setTitle("Add Profile", for: .normal)
        addProfileButton.setTitleColor(.neutral5, for: .normal)
        addProfileButton.tintColor = .neutral3
    }
    
    private func updateBackgroundView() {
        if data.isEmpty {
            let emptyView = UIView(frame: tableList.bounds)
            let imageView = UIImageView(image: UIImage.emptyBox1)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let label = UILabel()
            label.text = "Empty folder, Tap \"Add Profile\" to create profile now."
            label.numberOfLines = 0
            label.textColor = .neutral15
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let text = NSMutableAttributedString(string: label.text!)
            if let range = text.string.range(of: "\"Add Profile\"") {
                let nsRange = NSRange(range, in: label.text!)
                text.addAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .semibold), .foregroundColor: UIColor.primary1], range: nsRange)
            }

            label.attributedText = text
            
            emptyView.addSubview(imageView)
            emptyView.addSubview(label)
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: emptyView.topAnchor, constant: 300),

                imageView.widthAnchor.constraint(equalToConstant: 128),
                imageView.heightAnchor.constraint(equalToConstant: 128),
                
                label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
                label.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 0),
                label.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: 0)
            ])
            addProfileButton.isHidden = false
            tableList.backgroundView = emptyView
        } else {
            tableList.backgroundView = nil
            addProfileButton.isHidden = true
        }
        
        if !data.isEmpty {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(addProfileIconTapped))
            navigationItem.rightBarButtonItem?.tintColor = .primary1
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
//    private func updateNavigationBar() {
//        
//    }
    
    @objc private func addProfileIconTapped() {
        let vc = InformationVC(profile: .init(firstName: "", lastName: "", gender: "male", weight: 0, height: 0))
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        cell.configCell(profile: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ProfileVC(profile: data[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}



