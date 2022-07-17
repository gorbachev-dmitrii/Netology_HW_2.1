//
//  SettingsViewController.swift
//  Netology_HW_2.1
//
//  Created by Dima Gorbachev on 13.04.2022.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    private let userDefaults = UserDefaults.standard
    private lazy var switchSortSetting: UISwitch = {
        let switchView = UISwitch(frame: .zero)
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        return switchView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaults.value(forKey: "sort") != nil {
            print("+++")
        } else {
            switchSortSetting.setOn(false, animated: true)
            print("---")
        }
        //print(userDefaults.value(forKey: "sorting")!)
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
            cell.textLabel?.text = "Тут кнопка сменить пароль"
            return cell
        }
        
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        userDefaults.setValue(sender.isOn, forKey: "sorting")
        print(userDefaults.value(forKey: "sorting")!)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Сортировка"
        } else {
            return "Пароль"
        }
    }
}
