//
//  AuthView.swift
//  OfferBoard
//
//  Created by Рафаил Фаталиев on 24.05.2021.
//

import UIKit

class AuthView: UIView {
    
    let titlelabel = UILabel(text: "Авторизация",
                             font: RFFonts.titleLabelFont)
    let loginTF = UITextField(placeholder: "Введите Логин")
    let passwordTF = UITextField(placeholder: "Введите Пароль")
    let singInButton = UIButton(title: "Войти",
                                backgroundColor: RFColors.blue,
                                textColor: .white,
                                font: RFFonts.boldTextFont,
                                cornerRadius: 6)
    let singUpButton = UIButton(title: "Еще не с нами?",
                                backgroundColor: .clear,
                                textColor: RFColors.darkBlue,
                                font: RFFonts.boldTextFont,
                                cornerRadius: 0)
    init() {
        super.init(frame: CGRect())
        backgroundColor = RFColors.lightGray
        setupViews()
        setupConstraints()
    }
    func setupViews() {
        titlelabel.textAlignment = .center
        passwordTF.isSecureTextEntry = true
        
    }
    
    func setupConstraints() {
        
        //1 - отключить свойство translatesAutoresizingMaskIntoConstraints у каждого элемента
        
        //2 - добавить элементы на вью
        
        //3 выставить констрейнты
        
        let stack = UIStackView(arrangedSubviews: [titlelabel,
                                                   loginTF,
                                                   passwordTF,
                                                   singInButton,
                                                   singUpButton],
                                axis: .vertical,
                                spacing: 24)
        
        addSubview(stack)
        
        Helper.tamicOff(views: [stack, titlelabel, loginTF, passwordTF, singInButton, singUpButton])
        
        NSLayoutConstraint.activate([stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
                                     stack.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([loginTF.heightAnchor.constraint(equalToConstant: 40),
                                     passwordTF.heightAnchor.constraint(equalToConstant: 40),
                                     singInButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
