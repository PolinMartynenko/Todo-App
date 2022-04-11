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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        setUpButton()
        setUpLable()
        setUpEditButton()
      
    }

    
    @objc func addButtonTouched(){
        print("Touch")
        let alert = UIAlertController(title: nil, message: "Add your task", preferredStyle: .alert)
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
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setUpButton(){
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.gray, for: .normal)
        addButton.backgroundColor = .green
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(addButtonTouched), for: .touchUpInside)//обработка нажатия
        
        view.addSubview(addButton) //добавить кнопку
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setUpLable(){
        listLabel.text = "Task list is empty"
        view.addSubview(listLabel)
        listLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            listLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
    }
    private func setUpEditButton(){
        print("Touch")
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.red, for: .normal)
        editButton.backgroundColor = .blue //цвет фотки
        view.addSubview(editButton)
        editButton.layer.cornerRadius = 10 //скругление кнопки
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            editButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    
}

