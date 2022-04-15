//
//  AddToDoViewConroller.swift
//  TodoApp
//
//  Created by Polina Martynenko on 11.04.2022.
//

import UIKit

class AddToDoViewController: UIViewController {
//    let closedButton = UIButton()
    let textField = UITextField()
    let doneButton = UIButton()
    var delegate: AddToDoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.title = "Add tour task"
        setUpTextField()
        setUpDoneButton()
    }
    
    @objc func doneButtonTouch(){
        delegate?.setText(textField.text)
        navigationController?.popViewController(animated: true)//закрытие красного экрана
    }
    
    
    func setUpTextField(){
        textField.placeholder = "Enter your task"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        
        self.view.addSubview(textField) //показать текстфилд
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func setUpDoneButton(){
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.red, for: .normal)
        doneButton.backgroundColor = .white
        doneButton.addTarget(self, action: #selector(doneButtonTouch), for: .touchUpInside)
        
        //позиционирование
        self.view.addSubview(doneButton)//показать конпку
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            doneButton.centerXAnchor.constraint(equalTo: textField.centerXAnchor)
        ])
            
    }
    
    
}


protocol AddToDoDelegate {
    func setText(_ text: String?)
}
