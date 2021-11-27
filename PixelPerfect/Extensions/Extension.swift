//
//  Extension.swift
//  PixelPerfect
//
//  Created by Юрий Девятаев on 23.11.2021.
//

import UIKit

// MARK: - UIColor

extension UIColor {
    
    convenience init(_ hex: String, alpha: CGFloat = 1.0) {
      var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if cString.hasPrefix("#") { cString.removeFirst() }
      
      if cString.count != 6 {
        self.init("ff0000") // return red color for wrong hex input
        return
      }
      
      var rgbValue: UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)
      
      self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha)
    }
}

// MARK: - UIView
extension UIView{
    
    func cornerHalfHeight(){
        corner(withRadius: frame.height / 2)
    }
    func cornerHalfWidth(){
        corner(withRadius: frame.width / 2)
    }
    
    func corner(withRadius: CGFloat) {
        layer.cornerRadius = withRadius
//        layer.sublayers?.forEach{ $0.cornerRadius = withRadius}
        
        if self is UIImageView || self is UITextField || self is UILabel {
            clipsToBounds = true
        }
    }
    
    func border(withColor: UIColor, andWidth: CGFloat){
        layer.borderColor = withColor.cgColor
        layer.borderWidth = andWidth
    }
    
    func shadow(color: UIColor, width: Double, height: Double){
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = 10
    }
}

// MARK: - Bundle
extension Bundle {
    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        fatalError("Could not find view with this type " + String(describing: type))
    }
}
