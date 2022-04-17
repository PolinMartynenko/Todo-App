//
//  ViewController.swift
//  TodoApp
//
//  Created by Polina Martynenko on 10.04.2022.
//

import UIKit

class TodoListViewController: UIViewController {
    let addButton = UIButton()
    let listLabel = UILabel()
    let editButton = UIButton()
    let uiSwitch = UISwitch()
    let stackView = UIStackView()
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
    
    @objc func swichValueChanged(_ uiSwitch: UISwitch){
        print(uiSwitch.isOn)
//        entry.isCompleted = uiSwitch.isOn
    }
    
    @objc func editButtonTouched(){
        print("Touched")
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            print("Ok taped")
            let textField = alert.textFields?.first
            let text = textField?.text
            print(text)
            self.listLabel.text = text
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        alert.addTextField { textField in
            textField.placeholder = "Your task..."
            textField.text = self.listLabel.text
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setUpTableView(){
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
    
    private func setUpStackView(){
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
        ])
        
        setUpSwitch()
        setUpLable()
        setUpEditButton()
    }
    
    private func setUpSwitch (){
        uiSwitch.addTarget(self, action: #selector(swichValueChanged), for: .valueChanged)
//        uiSwitch.isOn = entry.isCompleted
        stackView.addArrangedSubview(uiSwitch)
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpLable(){
//        listLabel.text = entry.text
        listLabel.numberOfLines = 0
        stackView.addArrangedSubview(listLabel)
        listLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setUpEditButton(){
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.red, for: .normal)
        editButton.backgroundColor = .blue //цвет фотки
        stackView.addArrangedSubview(editButton)
        editButton.layer.cornerRadius = 10 //скругление кнопки
        editButton.addTarget(self, action: #selector(editButtonTouched), for: .touchUpInside)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            editButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let entry =  entries[indexPath.row]
        cell.textLabel?.text = entry.text
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
        
    }
    
}
