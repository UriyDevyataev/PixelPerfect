//
//  UserViewController.swift
//  PixelPerfect
//
//  Created by Юрий Девятаев on 24.11.2021.
//

import UIKit

private enum Titles{
    static var logOut = "Log out"
    static var infoOne = "Heiden Bierman"
    static var infoTwo = "Type to edit"
    static var loginDetails = "Login details"
    static var usernamePassword = "User name, Password"
    static var help = "Help"
    static var faqs = "FAQs, Helpdesk"
    static var legalInformation = "Legal information"
    static var terms = "Terms & Conditions, Privacy policy"
    static var faceId = "Face ID verification"
    static var enabledText = "Enabled"
}

class UserViewController: UIViewController {
    
    var content = [Content]()
    let identifireCell = "UserCollectionViewCellIdentifire"
    let colorBorder = UIColor("F3F3F3")

    @IBOutlet weak var collectionUser: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var infoLabelOne: UILabel!
    @IBOutlet weak var infoLabelTwo: UILabel!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var loginOutButton: UIButton!

    @IBAction func actionBack(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func createContent()->[Content]{
        
        let contentOne = Content(image: "person",
                                 title: Titles.loginDetails,
                                 subTitle: Titles.usernamePassword)
        let contentTwo = Content(image: "headphones",
                                 title: Titles.help,
                                 subTitle: Titles.faqs)
        let contentThree = Content(image: "list.bullet.rectangle.portrait",
                                   title: Titles.legalInformation,
                                   subTitle: Titles.terms)
        let contentFour = Content(image: "faceid",
                                  title: Titles.faceId,
                                  subTitle: Titles.enabledText)
        
        return [contentOne, contentTwo, contentThree, contentFour]
    }
    
    func config(){
        configViews()
        configLogo()
        configButton()
        configLabels()
        configCollectionUser()
        content = createContent()
    }
    
    func configCollectionUser(){
        collectionUser.delegate = self
        collectionUser.dataSource = self
        collectionUser.border(withColor: colorBorder, andWidth: 2)
        collectionUser.backgroundColor = colorBorder
        collectionUser.corner(withRadius: 20)
        collectionUser.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifireCell)
    }
    
    func configViews(){
        view.backgroundColor = UIColor.init("E9ECF5")
        mainContainerView.backgroundColor = UIColor.init("F7F8FB")
        mainContainerView.corner(withRadius: 40)
        bottomView.corner(withRadius: 40)
        bottomView.backgroundColor = .white
        bottomView.shadow(color: .black, width: 10, height: 10)
    }
    
    func configLabels(){
        var attributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
            NSAttributedString.Key.foregroundColor: UIColor.black]
        var attrTittle = NSMutableAttributedString(string: Titles.infoOne, attributes: attributes)
        infoLabelOne.attributedText = attrTittle
        
        attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        attrTittle = NSMutableAttributedString(string: Titles.infoTwo, attributes: attributes)
        infoLabelTwo.attributedText = attrTittle
    }
    
    func configLogo(){
        imageLogo.image = UIImage(named: "photo_man.jpg")
        imageLogo.corner(withRadius: 40)
    }
    
    func configButton(){
        addButton.corner(withRadius: 15)
        addButton.backgroundColor = .black
        addButton.setTitle("", for: .normal)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .white
        addButton.shadow(color: .black, width: 5, height: 5)
        
        backButton.setTitle("", for: .normal)
        backButton.cornerHalfWidth()
        backButton.backgroundColor = .white
        backButton.shadow(color: .black, width: 5, height: 5)
        
        loginOutButton.border(withColor: UIColor.black, andWidth: 1.5)
        loginOutButton.corner(withRadius: 20)
        
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "iphone.and.arrow.forward")
        configuration.imagePadding = 10
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .black
        loginOutButton.configuration = configuration
        let attributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        let attrTittle = NSMutableAttributedString(string: Titles.logOut, attributes: attributes)
        loginOutButton.setAttributedTitle(attrTittle, for: .normal)
        
    }
}

extension UserViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifireCell, for: indexPath) as? UserCollectionViewCell else {return UICollectionViewCell()}
        let cont = content[indexPath.row]
        cell.customImageView.image = UIImage(systemName: cont.image)
        
        var attributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.black]
        var attrTittle = NSMutableAttributedString(string: cont.title, attributes: attributes)
        cell.tittle.attributedText = attrTittle
        
        attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        attrTittle = NSMutableAttributedString(string: cont.subTitle, attributes: attributes)
        
        cell.subTitle.attributedText = attrTittle
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UserViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (collectionView.frame.size.height - CGFloat(content.count * 2))/4
        let size = CGSize(width: collectionView.frame.size.width,
                          height: height)
        return size
    }
}
