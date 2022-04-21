//
//  ViewController.swift
//  TodoApp
//
//  Created by Polina Martynenko on 10.04.2022.
//

import UIKit

class TodoListViewController: UIViewController {
    let addButton = UIButton()
    
    let tableView = UITableView()
    
    var entries = [Entry](){ //пустой массив
        didSet{
//            listLabel.text = entry.text
//            uiSwitch.isOn = entry.isCompleted
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        navigationItem.title = "Todo list"
        
        setUpAddButton()
//        setUpStackView()
        setUpTableView()
        
      
    }
    
    @objc func addButtonTouched(){
        let addToDoVC = AddToDoViewController()
        addToDoVC.delegate = self
        navigationController?.pushViewController(addToDoVC, animated:  true)
        
    }
    
    
    
    private func setUpTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EntryTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
    }
    
    private func setUpAddButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTouched))
    }
    
   
}


extension TodoListViewController: AddToDoDelegate {
    func setText(_ text: String?) {
//        entry.text = text ?? ""
        guard let text = text else {
            return
        }
        let entry = Entry(isCompleted: false, text: text)
        entries.append(entry)
    }
}

extension TodoListViewController: UITableViewDataSource { // создание ячеек таблицы(источник данных)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //ячейки для таблицы мы не инициализируем на прямую, а используем этот метод
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? EntryTableViewCell {
            var entry =  entries[indexPath.row]
            cell.listLabel.text = entry.text
            cell.uiSwitch.isOn = entry.isCompleted
            cell.handleSwitchChange = { isOn in
                entry.isCompleted = cell.uiSwitch.isOn
                self.entries[indexPath.row] = entry
            }
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
        
    }
    
}

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(entries[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            entries.remove(at: indexPath.row)
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
}
