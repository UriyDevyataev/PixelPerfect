//
//  UserCollectionViewCell.swift
//  PixelPerfect
//
//  Created by Юрий Девятаев on 25.11.2021.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentImageView: UIView!
    @IBOutlet weak var customButton: UIButton!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var tittle: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        customButton.setTitle("", for: .normal)
        customButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        customButton.tintColor = .black
        customImageView.tintColor = .black
        contentImageView.corner(withRadius: 10)
        contentImageView.border(withColor: .lightGray.withAlphaComponent(0.3), andWidth: 1)
    }
}
