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
    
    @IBOutlet weak var bottomContent: UIView!
    var isKeyboard = false
    
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
        let maxY = bottomContent.frame.maxY
        print(maxY)
//        showUser()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    // MARK: - Other Funcs
    func showUser(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "UserViewControllerIdent") as? UserViewController else {return}
        controller.modalPresentationStyle = .currentContext

//        navigationController?.present(controller, animated: true, completion: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func config(){
        configViews()
        configLogo()
        configLabels()
        configButtons()
        addContainers()
        createNotificationKeyBoard()
    }
    
    func configLogo(){
        imageLogo.image = UIImage(named: "elefant.jpeg")
        imageLogo.corner(withRadius: 20)
    }
    
    func configViews(){
        view.backgroundColor = UIColor.init("E9ECF5")
        userNameContentView.corner(withRadius: 20)
        passwordContentView.corner(withRadius: 20)
        organizationContentView.corner(withRadius: 20)
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
    
    func configButtons(){
        
        faceIdButtton.border(withColor: UIColor.black, andWidth: 1.5)
        faceIdButtton.corner(withRadius: 20)
        
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "faceid")
//        configuration.titlePadding = 10
        configuration.imagePadding = 10
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .black
    
//        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
//        let imageInserts = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        faceIdButtton.configuration = configuration
        
        loginButton.border(withColor: UIColor.black, andWidth: 1.5)
        loginButton.corner(withRadius: 20)
        loginButton.backgroundColor = .black
    
        
        var attributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        var attrTittle = NSMutableAttributedString(string: Titles.loginBut, attributes: attributes)
        loginButton.setAttributedTitle(attrTittle, for: .normal)
        
        attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        attrTittle = NSMutableAttributedString(string: Titles.faceIdBut, attributes: attributes)
        faceIdButtton.setAttributedTitle(attrTittle, for: .normal)
        

        attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        attrTittle = NSMutableAttributedString(string: Titles.forgotPasswordBut, attributes: attributes)
            
        forgotPasswordButton.setAttributedTitle(attrTittle, for: .normal)
        
    }
    
    // MARK: - Notifications KeyBoard
    
    func createNotificationKeyBoard(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            let maxY = bottomContent.frame.maxY
            print(maxY)
            if keyboardSize.origin.y < maxY {
                let offset = maxY - keyboardSize.origin.y
                UIView.animate(withDuration: 0.15, animations: { () -> Void in
                    self.view.transform = CGAffineTransform.init(translationX: 0, y: -offset)
//                        self.view.frame.origin.y  -= keyboardSize.height
                })
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.15, animations: { () -> Void in
//            self.view.frame.origin.y = 0
            self.view.transform = CGAffineTransform.identity
        })
    }
}

