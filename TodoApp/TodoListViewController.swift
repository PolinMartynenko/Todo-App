//
//  ViewController.swift
//  TodoApp
//
//  Created by Polina Martynenko on 10.04.2022.
//

import UIKit

enum Filter: Int{
    case all
    case completed
}

class TodoListViewController: UIViewController {
    let segmenredControl = UISegmentedControl(items: ["All", "Completed"])
    let tableView = UITableView()
    
    
    var filter = Filter.all
    
    var allEntries: [Entry] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var filtredEntries : [Entry] {
        allEntries.filter { entry in
            switch filter {
            case .all:
                return true
            case .completed:
                return entry.isCompleted
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        view.backgroundColor = .green
        navigationItem.title = "Todo list"
        view.backgroundColor = .pinkForTodoList
        
        
        setUpAddButton()
        setUpSegmentedControl()
        setUpTableView()
        
        
        if let data = UserDefaults.standard.value(forKey:"com.all.entries" ) as? Data {
            let decoder = JSONDecoder()
            do{
                let entries = try decoder.decode([Entry].self, from: data)
                self.allEntries = entries
            } catch {
                print(error)
            }
        }
    }
    
    @objc func addButtonTouched(){
        let addToDoVC = AddToDoViewController()
        addToDoVC.delegate = self
        navigationController?.pushViewController(addToDoVC, animated:  true)
        
    }
    
    @objc func segmentesControlChanged( _segmentedControl: UISegmentedControl){
        filter = Filter(rawValue: segmenredControl.selectedSegmentIndex) ?? .all
        tableView.reloadData()
        print(filter)
    }
    
    private func setUpSegmentedControl(){
        segmenredControl.selectedSegmentIndex = 0
        segmenredControl.addTarget(self, action: #selector(segmentesControlChanged), for: .valueChanged)
        self.view.addSubview(segmenredControl)
        segmenredControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmenredControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmenredControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            segmenredControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    
    private func setUpTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EntryTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 15
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmenredControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
    }
    
    private func setUpAddButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTouched))
    }
   
    func handleEditChange(_ entry: Entry) {
        var entry = entry
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            print("Ok taped")
            let textField = alert.textFields?.first
            let text = textField?.text
            print(text)
            entry.text = textField?.text ?? ""
            guard let index =  self.allEntries.firstIndex(where: { $0.id == entry.id }) else {
                return
            }
            self.allEntries[index] = entry
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        alert.addTextField { textField in
            textField.placeholder = "Your task..."
            textField.text = entry.text
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveAllEntries(){
        let encoder = JSONEncoder()//???????????? ?????????????? ???????????????? ???? ?????????????? ????????????
        do{
            let data =  try encoder.encode(allEntries)
            UserDefaults.standard.set(data, forKey: "com.all.entries")
        } catch {
            print(error)
        }
    }
}


extension TodoListViewController: AddToDoDelegate {
    func setText(_ text: String?, _ date: Date? ) {
//        entry.text = text ?? ""
        guard let text = text else {
            return
        }
        let entry = Entry(isCompleted: false, text: text, date: date )
        allEntries.append(entry)
        
        saveAllEntries()
    }
}


extension TodoListViewController: UITableViewDataSource { // ???????????????? ?????????? ??????????????(???????????????? ????????????)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //???????????? ?????? ?????????????? ???? ???? ???????????????????????????? ???? ????????????, ?? ???????????????????? ???????? ??????????
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? EntryTableViewCell {
            var entry =  filtredEntries[indexPath.row]
            cell.listLabel.text = entry.text
//            cell.dateLable.text = entry.date
            if let date = entry.date {
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "dd.MM.yy HH:mm"
                cell.dateLable.text = "\(dateFormatterGet.string(from: date))"
            }
            cell.uiSwitch.isOn = entry.isCompleted
            cell.handleSwitchChange = { isOn in
                entry.isCompleted = isOn
                guard let indexToChange = self.allEntries.firstIndex(where: { $0.id == entry.id }) else { return }
                self.allEntries[indexToChange] = entry
                self.saveAllEntries()
            }
            cell.handleEditChange = {
                self.handleEditChange(entry)
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
        return filtredEntries.count
        
    }
    
}

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(filtredEntries[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let entry = filtredEntries[indexPath.row]
            guard let index = allEntries.firstIndex(where: {
                $0.id == entry.id
            }) else { return }
            allEntries.remove(at: index)
            saveAllEntries()
        }
    }
    
    func tableView(_: UITableView, heightForRowAt: IndexPath) -> CGFloat{
        return 70
    }
    
    
}
