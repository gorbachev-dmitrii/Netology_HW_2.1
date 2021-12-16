//
//  ViewController.swift
//  Netology_HW_2.1
//
//  Created by Dima Gorbachev on 06.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let fileManager = FileManager.default
    var content: [URL] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить фото", style: .plain, target: self, action: #selector(displayImagePickerButtonTapped))
        view.addSubview(tableView)
        setupConstraints()
        loadDocumentFolder()
    }
    
    @objc func displayImagePickerButtonTapped(_ sender:UIButton!) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func loadDocumentFolder() {
        
        let documentsURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        print(documentsURL)
        
        content = try! fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: [])
        
//        if !content.isEmpty {
//            content.forEach {
//                print("url is: \($0.absoluteURL)")
//            }
//        } else {
//            print("empty")
//        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel!.text = content[indexPath.row].path
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let path = content[indexPath.row].path
        
        try! fileManager.removeItem(atPath: path)
        tableView.reloadData()
        print("row at \(indexPath) deleted")
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let documentsURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let image = info[.originalImage] as! UIImage
        let imageData = image.pngData()
        let imageName = UUID().uuidString
        let fileUrl = documentsURL.appendingPathComponent(imageName)
        try! fileManager.createFile(atPath: fileUrl.path, contents: imageData, attributes: nil)
        self.dismiss(animated: true, completion: nil)
    }
}

