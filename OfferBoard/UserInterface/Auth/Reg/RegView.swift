

import UIKit

class RegView: UIView {
    
    let titleLabelReg = UILabel(text: "Регистрация", font: RFFonts.titleLabelFont)
    let surName = UITextField (placeholder: "Фамилия")
    let surNameLabel = UILabel(text:"Фамилия",font: RFFonts.regularTextFont)
    let name = UITextField (placeholder: "Имя")
    let nameLabel = UILabel(text:"Имя",font: RFFonts.regularTextFont)
    let phoneNumberLabel = UILabel(text:"Номер телефона",font:RFFonts.regularTextFont)
    let codeOfPhoneNumber = UILabel (text: "+7", font: RFFonts.titleLabelFont)
    let phoneNumber = UITextField (placeholder: "Номер телефона")
    let eMail = UITextField(placeholder: "Введите email")
    let eMailLabel = UILabel(text: "Email", font: RFFonts.regularTextFont)
    let passwordTFReg = UITextField (placeholder: "Введите пароль")
    let passwordTFRegLabel = UILabel(text: "Пароль", font: RFFonts.regularTextFont)
    let regButton = UIButton(title: "Регистрация", backgroundColor: RFColors.blue, textColor: .white, font: RFFonts.boldTextFont, cornerRadius: 6)
    let signInButtonIfHave = UIButton(title: "Уже есть аккаунт? Войти.", backgroundColor: .clear, textColor: .blue, font: RFFonts.boldTextFont, cornerRadius: 6)
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = RFColors.lightGray
        setupViews()
        setupConstraints()
        
    }
    
    func setupViews() {
        titleLabelReg.textAlignment = .center
        passwordTFReg.isSecureTextEntry = true
    }
    
    func setupConstraints() {
        
        let stack1 = UIStackView(arrangedSubviews: [titleLabelReg,surNameLabel,surName,nameLabel,name], axis: .vertical, spacing: 12)
        stack1.translatesAutoresizingMaskIntoConstraints = false
        
        
        Helper.tamicOff(views: [titleLabelReg,surNameLabel,surName,nameLabel,name])
        surName.layer.cornerRadius = 15
        name.layer.cornerRadius = 15
        
        
        let phoneStack = UIStackView(arrangedSubviews: [codeOfPhoneNumber,phoneNumber], axis: .horizontal, spacing: 12)
        phoneStack.translatesAutoresizingMaskIntoConstraints = false
        
        Helper.tamicOff(views: [codeOfPhoneNumber,phoneNumber])
        phoneNumber.layer.cornerRadius = 15
        
        let stack2 = UIStackView(arrangedSubviews: [eMailLabel,eMail,passwordTFRegLabel,passwordTFReg], axis: .vertical, spacing: 24)
        stack2.translatesAutoresizingMaskIntoConstraints = false
        
        Helper.tamicOff(views: [eMailLabel,eMail,passwordTFRegLabel,passwordTFReg])
        eMail.layer.cornerRadius = 15
        passwordTFReg.layer.cornerRadius = 15
        
        let stack3 = UIStackView(arrangedSubviews: [regButton,signInButtonIfHave], axis: .vertical, spacing: 12)
        stack3.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [stack1, phoneStack, stack2, stack3], axis: .vertical, spacing: 16)
        
        addSubview(stack)
        
        Helper.tamicOff(views: [regButton,signInButtonIfHave, stack])
        
        NSLayoutConstraint.activate([codeOfPhoneNumber.widthAnchor.constraint(equalToConstant: 28),
                                     phoneNumber.heightAnchor.constraint(equalToConstant : 40),
                                     phoneNumber.leadingAnchor.constraint(equalTo: codeOfPhoneNumber.trailingAnchor, constant: 8),
                                     phoneNumber.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([titleLabelReg.heightAnchor.constraint(equalToConstant:40),
                                     surName.heightAnchor.constraint(equalToConstant : 40),
                                     name.heightAnchor.constraint(equalToConstant: 40),])
        
        NSLayoutConstraint.activate([eMail.heightAnchor.constraint(equalToConstant:40),
                                     passwordTFReg.heightAnchor.constraint(equalToConstant : 40)])
        
        NSLayoutConstraint.activate([stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
                                     stack.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     stack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([regButton.heightAnchor.constraint(equalToConstant: 40),
                                     signInButtonIfHave.heightAnchor.constraint(equalToConstant: 40)])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}



