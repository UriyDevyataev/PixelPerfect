//
//  TestViewController.swift
//  PixelPerfect
//
//  Created by Юрий Девятаев on 27.11.2021.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    @IBOutlet weak var text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        text.delegate = self
        createNotificationKeyBoard()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionButton(_ sender: Any) {
//        print(view.frame.height)
//        print("textField.Y = \(text.frame.origin.y)")
//        print("textField.heigh = \(text.frame.height)")
//        let bottom = view.frame.height - text.frame.origin.y - text.frame.height
//        print("bottom = \(bottom)")
        print("bottomMaxY = \(text.frame.maxY)")
//        print("bottomHeight = \(bottomHeight.constant)")
    }
    // MARK: - Notifications KeyBoard
    
    func createNotificationKeyBoard(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            let maxY = text.frame.maxY + 5
            print(maxY)
//            print(faceIdButtton.frame.origin.y)
            if keyboardSize.origin.y < maxY {
                let offset = maxY - keyboardSize.origin.y
                UIView.animate(withDuration: 0.15, animations: { () -> Void in
                    self.view.transform = CGAffineTransform.init(translationX: 0, y: -offset)
//                    self.view.frame.origin.y  -= keyboardSize.height
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

extension TestViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
