//
//  ViewController.swift
//  PixelPerfect
//
//  Created by Юрий Девятаев on 23.11.2021.
//

import UIKit
import SnapKit

private enum Titles{
    static var infoOne = "Login to beUpToDate"
    static var infoTwo = "Trailer info at a glance"
    static var faceIdBut = "Face ID"
    static var loginBut = "Login"
    static var forgotPasswordBut = "Forgot your password or user name?"
}

class ViewController: UIViewController {
    @IBOutlet weak var middleContent: UIView!
    
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var infoLabelOne: UILabel!
    @IBOutlet weak var infoLabelTwo: UILabel!
    
    @IBOutlet weak var userNameContentView: UIView!
    @IBOutlet weak var passwordContentView: UIView!
    @IBOutlet weak var organizationContentView: UIView!
    
    @IBOutlet weak var faceIdButtton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBAction func actionLogin(_ sender: UIButton) {
        actionEndEditing()
        showUser()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }

    // MARK: - Funcs config
    func config(){
        configViews()
        configLogo()
        configLabels()
        configButtons()
        addContainers()
        createTap()
        createNotificationKeyBoard()
    }
    
    func configViews(){
        view.backgroundColor = UIColor.init("E9ECF5")
        userNameContentView.corner(withRadius: 15)
        passwordContentView.corner(withRadius: 15)
        organizationContentView.corner(withRadius: 15)
        userNameContentView.clipsToBounds = true
        passwordContentView.clipsToBounds = true
        organizationContentView.clipsToBounds = true
    }
    
    func configLogo(){
        imageLogo.image = UIImage(named: "elefant.jpeg")
        imageLogo.corner(withRadius: 20)
    }
    
    func configLabels(){
        let attributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        var attrTittle = NSMutableAttributedString(string: Titles.infoTwo, attributes: attributes)
        infoLabelTwo.attributedText = attrTittle
        
        attrTittle = NSMutableAttributedString(string: Titles.infoOne)
        attrTittle.addAttribute(NSMutableAttributedString.Key.foregroundColor,
                                value: UIColor("0040FA"),
                                range: NSRange(location: 9, length: 10))
        attrTittle.addAttribute(NSMutableAttributedString.Key.font,
                                value: UIFont.boldSystemFont(ofSize: 22),
                                range: NSRange(location: 0, length:attrTittle.length))
        infoLabelOne.attributedText = attrTittle
    }
    
    func createTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionEndEditing))
        view.addGestureRecognizer(tap)
    }
    
    func addContainers(){
        let userNameView = Bundle.loadView(fromNib: "CustomViewXIB", withType: CustomViewXIB.self)
        userNameView.configContainer(forContent: .username)
        userNameView.tapButton = {
            print("clear from userNameView")
            userNameView.inputText.attributedText = NSMutableAttributedString(string: "")
            userNameView.hiddenButton()
        }
        
        userNameContentView.addSubview(userNameView)
        userNameView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        let organozationView = Bundle.loadView(fromNib: "CustomViewXIB", withType: CustomViewXIB.self)
        organozationView.configContainer(forContent: .organization)
        organozationView.tapButton = {
            print("clear from organozationView")
            organozationView.inputText.attributedText = NSMutableAttributedString(string: "")
            organozationView.hiddenButton()
        }
        
        organizationContentView.addSubview(organozationView)
        organozationView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        let passwordView = Bundle.loadView(fromNib: "CustomViewXIB", withType: CustomViewXIB.self)
        passwordView.configContainer(forContent: .password)
        passwordView.tapButton = {
            passwordView.inputText.isSecureTextEntry = !passwordView.inputText.isSecureTextEntry
        }

        passwordContentView.addSubview(passwordView)
        passwordView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    
    
    func configButtons(){
        faceIdButtton.border(withColor: UIColor.black, andWidth: 1.5)
        faceIdButtton.corner(withRadius: 15)
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "faceid")
        configuration.imagePadding = 10
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .black
        faceIdButtton.configuration = configuration
        
        var attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        var attrTittle = NSMutableAttributedString(string: Titles.faceIdBut, attributes: attributes)
        faceIdButtton.setAttributedTitle(attrTittle, for: .normal)
        
        loginButton.border(withColor: UIColor.black, andWidth: 1.5)
        loginButton.corner(withRadius: 15)
        loginButton.backgroundColor = .black
    
        attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        attrTittle = NSMutableAttributedString(string: Titles.loginBut, attributes: attributes)
        loginButton.setAttributedTitle(attrTittle, for: .normal)
        
        attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        attrTittle = NSMutableAttributedString(string: Titles.forgotPasswordBut, attributes: attributes)
            
        forgotPasswordButton.setAttributedTitle(attrTittle, for: .normal)
    }
    
    // MARK: - Other Funcs
    
    @objc func actionEndEditing(){
        view.endEditing(true)
    }
    
    func showUser(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "UserViewControllerIdent") as? UserViewController else {return}
        controller.modalPresentationStyle = .currentContext

//        navigationController?.present(controller, animated: true, completion: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Notifications KeyBoard
    
    func createNotificationKeyBoard(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            let maxY = middleContent.frame.maxY + 10
            if keyboardSize.origin.y < maxY {
                let offset = maxY - keyboardSize.origin.y
                UIView.animate(withDuration: 0.15, animations: { () -> Void in
                    self.view.transform = CGAffineTransform.init(translationX: 0, y: -offset)
                })
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.15, animations: { () -> Void in
            self.view.transform = CGAffineTransform.identity
        })
    }
}

