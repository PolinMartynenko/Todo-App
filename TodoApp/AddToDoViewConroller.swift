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
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .skyBlue
        navigationItem.title = "Add tour task"
        setUpTextField()
        setUpDatePicker()
        setUpDoneButton()
    }
    
    @objc func doneButtonTouch(){
        delegate?.setText(textField.text, datePicker.date)
        navigationController?.popViewController(animated: true)//закрытие красного экрана
    }
    
    
    func setUpTextField(){
        textField.placeholder = "Enter your task"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.returnKeyType = .done
        
        self.view.addSubview(textField) //показать текстфилд
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func setUpDatePicker(){
        self.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: textField.bottomAnchor),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpDoneButton(){
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = .blue
        doneButton.layer.cornerRadius = 10
        doneButton.addTarget(self, action: #selector(doneButtonTouch), for: .touchUpInside)
        
        //позиционирование
        self.view.addSubview(doneButton)//показать конпку
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 5),
            doneButton.centerXAnchor.constraint(equalTo: textField.centerXAnchor)
        ])
            
    }
    
    
}
extension AddToDoViewController: UITextFieldDelegate{
    //количество символов в строке написанных//этот метод вызывается каждый раз когда юзер вводит символ на клавиатуре, здесь мы определяем разрешаем ли мы вводить его дальше
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        
        guard let stringRange = Range(range, in: text) else {return false}
        let updateText = text.replacingCharacters(in: stringRange, with: string)
        return updateText.count <= 25
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //обработка нажатия кнопки done на клавиатуре.
        print("return touched")
        delegate?.setText(textField.text, datePicker.date)
        navigationController?.popViewController(animated: true)
        return true
    }
}

protocol AddToDoDelegate {
    func setText(_ text: String?,_ date:Date?)
}
