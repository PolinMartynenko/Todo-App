//
//  AddToDoViewConroller.swift
//  TodoApp
//
//  Created by Polina Martynenko on 11.04.2022.
//

import UIKit

class AddToDoViewController: UIViewController {
    let closedButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
        setUpClousedButton()
    }
    
    @objc func closedButtonTouched(){
        print("Touched")
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUpClousedButton(){
        closedButton.setTitle("Cloused", for: .normal)
        closedButton.backgroundColor = .green
        closedButton.setTitleColor(.black, for: .normal)
        
        closedButton.addTarget(self, action: #selector(closedButtonTouched), for: .touchUpInside)
        view.addSubview(closedButton) //добавить кнопку
        closedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            closedButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            closedButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    
    
}
