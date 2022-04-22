//
//  EntryTableViewCell.swift
//  TodoApp
//
//  Created by Polina Martynenko on 19.04.2022.
//

import UIKit

class EntryTableViewCell : UITableViewCell {
    let listLabel = UILabel()
    let editButton = UIButton()
    let uiSwitch = UISwitch()
    let stackView = UIStackView()
    var handleSwitchChange: ((Bool) -> Void)?
    var handleEditChange: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .cyan
        setUpStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func swichValueChanged(_ uiSwitch: UISwitch){
        print(uiSwitch.isOn)
        handleSwitchChange?(uiSwitch.isOn)
//        entry.isCompleted = uiSwitch.isOn
    }
    
    @objc func editButtonTouched(_ editButton: UIButton){
        print("Touched")
        handleEditChange?()
    }
    
    private func setUpStackView(){
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
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

