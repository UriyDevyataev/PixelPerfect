//
//  CustomButton.swift
//  PixelPerfect
//
//  Created by Юрий Девятаев on 25.11.2021.
//

import UIKit

class CustomButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundColor = .lightGray
//        self.tintColor = .black
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = self.self.isHighlighted ? UIColor.black : UIColor.clear
                self.tintColor = self.self.isHighlighted ? UIColor.white : UIColor.black
            }
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
