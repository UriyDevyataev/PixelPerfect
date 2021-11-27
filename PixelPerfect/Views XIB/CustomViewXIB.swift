//
//  CustomViewXIB.swift
//  PixelPerfect
//
//  Created by Юрий Девятаев on 23.11.2021.
//

import UIKit

enum TypeContent{
    case username
    case organization
    case password
}

private enum TitlesXIB{
    static var username = "User name"
    static var organization = "Organization"
    static var password = "Password"
}

private enum ImageNameXIB{
    static var clear = "multiply"
    static var visible = "eye"
}

class CustomViewXIB: UIView {
        
    var tapButton: (()->())?

    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var delimiterView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    private func config(){
        configInputText()
        configViews()
    }
    
    private func configViews(){
        corner(withRadius: 20)
        delimiterView.backgroundColor = .lightGray.withAlphaComponent(0.2)
    }
    
    private func configInputText(){
        let attributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.black]
        inputText.defaultTextAttributes = attributes
        inputText.borderStyle = .none
        inputText.delegate = self
    }
    
    func configContainer(forContent: TypeContent){
        switch forContent {
        case .username:
            configPlaceholder(text: TitlesXIB.username)
            configButton(imageName: ImageNameXIB.clear)
        case .organization:
            configPlaceholder(text: TitlesXIB.organization)
            configButton(imageName: ImageNameXIB.clear)
        case .password:
            configPlaceholder(text: TitlesXIB.password)
            configButton(imageName: ImageNameXIB.visible)
            inputText.isSecureTextEntry = true
        }
    }
    
    private func configPlaceholder(text: String){
        let attributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ]
        let attrTittle = NSMutableAttributedString(string: text, attributes: attributes)
        placeHolderLabel.attributedText = attrTittle
    }
    
    private func configButton(imageName: String){
        textButton.setImage(UIImage(systemName: imageName), for: .normal)
        textButton.alpha = 0
        delimiterView.alpha = 0
    }
    
    private func showButton(){
        UIView.animate(withDuration: 0.2) {
            self.textButton.alpha = 1
            self.delimiterView.alpha = 1
        }
    }
    
    func hiddenButton(){
        UIView.animate(withDuration: 0.2) {
            self.textButton.alpha = 0
            self.delimiterView.alpha = 0
        }
    }
    
    @IBAction func actionTextButton(_ sender: UIButton) {
        tapButton?()
    }
}

extension CustomViewXIB: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {return true}
        var newText = ""
        
        if string != "" {
            newText = text + string
        } else{
            newText = String(text.dropLast())
        }
        newText != "" ? showButton() : hiddenButton()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            hiddenButton()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
