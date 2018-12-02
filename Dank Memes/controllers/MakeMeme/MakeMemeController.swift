//
//  MakeMemeController.swift
//  Dank Memes
//
//  Created by Osama on 28/07/18.
//  Copyright © 2018 Ruben. All rights reserved.
//

import UIKit

class MakeMemeController: UIViewController {
    
    lazy var myScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    lazy var myMemeView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var memeTextsView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var myImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    lazy var topMemeTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = "TOP_MEME_TXT".localised
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var middleMemeTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = "MIDDLE_MEME_TXT".localised
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var bottomMemeTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = "BOTTOM_MEME_TXT".localised
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var myButton : UIButton = {
        let button = UIButton()
        button.setTitle("CREATE_MEME".localised, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        button.addTarget(self, action: #selector(createMeme), for: .touchUpInside)
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.backgroundColor = Constants.buttonColor
        return button
    }()
    
    lazy var topMemeLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.backgroundColor = UIColor.clear
        myLabel.textColor = UIColor.white
        myLabel.font = UIFont.boldSystemFont(ofSize: 25)
        myLabel.text = "TOP_MEME_TXT_HINT".localised
        myLabel.textAlignment = .center
        myLabel.lineBreakMode = .byWordWrapping
        myLabel.numberOfLines = 0
        return myLabel
    }()
    
    lazy var middleMemeLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.backgroundColor = UIColor.clear
        myLabel.textColor = UIColor.white
        myLabel.font = UIFont.boldSystemFont(ofSize: 25)
        myLabel.text = "MIDDLE_MEME_TXT_HINT".localised
        myLabel.textAlignment = .center
        myLabel.lineBreakMode = .byWordWrapping
        myLabel.numberOfLines = 0
        return myLabel
    }()
    
    lazy var bottomMemeLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.backgroundColor = UIColor.clear
        myLabel.textColor = UIColor.white
        myLabel.font = UIFont.boldSystemFont(ofSize: 25)
        myLabel.text = "BOTTOM_MEME_TXT_HINT".localised
        myLabel.textAlignment = .center
        myLabel.lineBreakMode = .byWordWrapping
        myLabel.numberOfLines = 0
        return myLabel
    }()
    
    var topFlag: Bool = true
    var midFlag: Bool = true
    var bottomFlag: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.memeTextsView.addGestureRecognizer(tap)
        self.topMemeTextField.addGestureRecognizer(tap)
        self.middleMemeTextField.addGestureRecognizer(tap)
        self.bottomMemeTextField.addGestureRecognizer(tap)
        self.myScrollView.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = "MAKE_MEME".localised
    }
    
    func setUpViews(){
        
        let deviceSize = UIScreen.main.bounds
        let deviceWidth = deviceSize.width
        let deviceHeight = deviceSize.height
        let textFieldHeight = 60
        let imageViewHeight = 400
        let buttonHeight = 40
        let memeTextHeight = (textFieldHeight * 3) + (16 * 3)
        
        topMemeTextField.setBottomBorder()
        middleMemeTextField.setBottomBorder()
        bottomMemeTextField.setBottomBorder()
        
        memeTextsView.addSubview(topMemeTextField)
        memeTextsView.addSubview(middleMemeTextField)
        memeTextsView.addSubview(bottomMemeTextField)
        myScrollView.addSubview(memeTextsView)
        myScrollView.addSubview(myButton)
        myMemeView.addSubview(myImageView)
        myMemeView.addSubview(topMemeLabel)
        myMemeView.addSubview(middleMemeLabel)
        myMemeView.addSubview(bottomMemeLabel)
        myScrollView.addSubview(myMemeView)
        self.view.addSubview(myScrollView)
        
        _ = myScrollView.anchor(topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: deviceWidth, heightConstant: deviceHeight)
        
        _ = memeTextsView.anchor(myScrollView.topAnchor, left: myScrollView.leftAnchor, bottom: myButton.topAnchor, right: myScrollView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: deviceWidth, heightConstant: CGFloat(memeTextHeight))
        
        _ = topMemeTextField.anchor(memeTextsView.topAnchor, left: memeTextsView.leftAnchor, bottom: nil, right: memeTextsView.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: deviceWidth, heightConstant: CGFloat(textFieldHeight))
        
        _ = middleMemeTextField.anchor(topMemeTextField.bottomAnchor, left: memeTextsView.leftAnchor, bottom: nil, right: memeTextsView.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: deviceWidth, heightConstant: CGFloat(textFieldHeight))
        
        _ = bottomMemeTextField.anchor(middleMemeTextField.bottomAnchor, left: memeTextsView.leftAnchor, bottom: nil, right: memeTextsView.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: deviceWidth, heightConstant: CGFloat(textFieldHeight))
        
        _ = myButton.anchor(memeTextsView.bottomAnchor, left: myScrollView.leftAnchor, bottom: myMemeView.topAnchor, right: myScrollView.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: deviceWidth, heightConstant: CGFloat(buttonHeight))
        
        _ = myMemeView.anchor(myButton.bottomAnchor, left: myScrollView.leftAnchor, bottom: myScrollView.bottomAnchor, right: myScrollView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: deviceWidth, heightConstant: CGFloat(imageViewHeight))
        
        _ = myImageView.anchor(myMemeView.topAnchor, left: myMemeView.leftAnchor, bottom: myMemeView.bottomAnchor, right: myMemeView.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: deviceWidth, heightConstant: CGFloat(imageViewHeight))
        
        _ = topMemeLabel.anchor(myImageView.topAnchor, left: myImageView.leftAnchor, bottom: nil, right: myImageView.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: deviceWidth, heightConstant: 50)
        
        _ = middleMemeLabel.anchor(topMemeLabel.bottomAnchor, left: myImageView.leftAnchor, bottom: bottomMemeLabel.topAnchor, right: nil, topConstant: 25, leftConstant: 8, bottomConstant: 30, rightConstant: 0, widthConstant: 100, heightConstant: 200)
        
        _ = bottomMemeLabel.anchor(nil, left: myImageView.leftAnchor, bottom: myImageView.bottomAnchor, right: myImageView.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: deviceWidth, heightConstant: 70)
        
        if((UserDefaults.standard.bool(forKey: "SelectedMemeImage"))){
            let urlString = UserDefaults.standard.value(forKey: "SelectedImage") as? String
            let url = NSURL(string: urlString!)
            let imageData = NSData(contentsOf: url! as URL)
            myImageView.image = UIImage(data: imageData! as Data)
        }
        else if(UserDefaults.standard.bool(forKey: "SelectedGalleryOrCameraImage")){
            let pickedImage = UIImage(data: UserDefaults.standard.value(forKey: "SelectedImage") as! Data)
            let newImage = UIImage(cgImage: (pickedImage?.cgImage!)!, scale: 1.0, orientation: UIImageOrientation.right)
            myImageView.image = newImage
        }
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func createMeme(){
        var myImage: UIImage? = nil
        let urlString = UserDefaults.standard.value(forKey: "SelectedImage") as? String
        let url = NSURL(string: urlString!)
        let imageData = NSData(contentsOf: url! as URL)
        let memeImage = UIImage(data: imageData! as Data)!
        //If there is top meme text then draw it on image
        if(topMemeTextField.text != ""){
            midFlag = false
            bottomFlag = false
            myImage = makeMeme(drawText: topMemeTextField.text! as NSString, inImage: memeImage, atPoint: CGPoint(x: 20, y: 20))
        }
        
        //If there is middle meme text then draw it on image
        if(middleMemeTextField.text != ""){
            topFlag = false
            midFlag = true
            bottomFlag = false
            if(myImage != nil){
                myImage = makeMeme(drawText: middleMemeTextField.text! as NSString, inImage: myImage!, atPoint: CGPoint(x: 10, y: memeImage.size.height/2 - 20))
            }else{
                myImage = makeMeme(drawText: middleMemeTextField.text! as NSString, inImage: memeImage, atPoint: CGPoint(x: 10, y: memeImage.size.height/2 - 20))
            }
        }
        
        //If there is bottom meme text then draw it on image
        if(bottomMemeTextField.text != ""){
            topFlag = false
            midFlag = false
            bottomFlag = true
            if(myImage != nil){
                myImage = makeMeme(drawText: bottomMemeTextField.text! as NSString, inImage: myImage!, atPoint: CGPoint(x: 10, y: memeImage.size.height - 80))
            }else{
                myImage = makeMeme(drawText: bottomMemeTextField.text! as NSString, inImage: memeImage, atPoint: CGPoint(x: 10, y: memeImage.size.height - 80))
            }
        }
        
        let finalMeme = ShowFinalMemeController()
        finalMeme.finalImage = myImage
        self.navigationController?.pushViewController(finalMeme, animated: true)
    }
    
    func makeMeme(drawText: NSString, inImage: UIImage, atPoint: CGPoint) -> UIImage{
        
        var rect: CGRect? = nil
        
        // Setup the font specific variables
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 25)!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedStringKey.font:  textFont,
            NSAttributedStringKey.foregroundColor: textColor
        ]
        
        // Put the image into a rectangle as large as the original image
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        
        // Create a point within the space
        let textSize = drawText.size(withAttributes: textFontAttributes)
        
        if(topFlag){
        rect = CGRect(x:inImage.size.width / 2 - textSize.width / 2, y:atPoint.y,
                          width:inImage.size.width, height:60)
        }else if(midFlag){
            rect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width/2, height: 50)
        }else{
            rect = CGRect(x:inImage.size.width / 2 - textSize.width / 2, y:atPoint.y,
                          width:inImage.size.width, height:60)
        }
        
        // Draw the text into an image
        drawText.draw(in: rect!, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        return newImage!
        
    }
    
}
