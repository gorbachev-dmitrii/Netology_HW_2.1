//
//  SettingsViewController.swift
//  Netology_HW_2.1
//
//  Created by Dima Gorbachev on 13.04.2022.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    private lazy var switchSortSetting: UISwitch = {
        let switchView = UISwitch(frame: .zero)
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        if Constants.settings.bool(forKey: Constants.sortingSetting) {
            switchView.isOn = true
        } else {
            switchView.isOn = false
        }
        return switchView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func switchChanged(_ sender : UISwitch!){
        Constants.settings.set(sender.isOn, forKey: Constants.sortingSetting)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = "Алфавитный порядок"
            cell.accessoryView = switchSortSetting
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell1")
            cell.textLabel?.text = "Cменить пароль"
            cell.accessoryType = .detailButton
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(indexPath.row)
        let vc = LoginViewController()
        self.present(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Сортировка"
        case 1:
            return "Пароль"
        default:
            return "В разработке"
        }
    }
}
