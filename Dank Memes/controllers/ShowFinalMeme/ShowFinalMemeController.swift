//
//  ShowFinalMemeController.swift
//  Dank Memes
//
//  Created by Ruben on 17/11/18.
//  Copyright © 2018 Ruben. All rights reserved.
//

import UIKit

class ShowFinalMemeController: UIViewController {
    
    var finalImage:UIImage? = nil
    
    lazy var myScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    lazy var finalMemeView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 12.0
        view.layer.shadowOpacity = 0.7
        return view
    }()
    
    lazy var finalMemeImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    lazy var memeTitle : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.textAlignment = .natural
        textField.placeholder = "YOUR_TITLE".localised
        textField.setBottomBorder()
        return textField
    }()
    
    lazy var titileLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.backgroundColor = UIColor.white
        myLabel.textAlignment = .natural
        myLabel.text = "MEME_TITLE".localised
        return myLabel
    }()
    
    lazy var saveMemeButton : UIButton = {
        let button = UIButton()
        button.setTitle("SAVE_MEME".localised, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        button.addTarget(self, action: #selector(saveMeme), for: .touchUpInside)
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.backgroundColor = Constants.buttonColor
        return button
    }()
    
    lazy var shareMemeButton : UIButton = {
        let button = UIButton()
        button.setTitle("SHARE_MEME".localised, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        button.addTarget(self, action: #selector(shareMeme), for: .touchUpInside)
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.backgroundColor = Constants.buttonColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        memeTitle.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = "DANK_MEME".localised
    }
    
    @objc func saveMeme(){
        if(memeTitle.text != ""){
            guard let selectedImage = finalImage else {
                print("Image not found!")
                return
            }
            UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
        }else{
            DispatchQueue.global(qos: .userInitiated).sync {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "TITLE_ALRT".localised, message: "TITLE_MSG".localised, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            return
        }
    }
    
    @objc func saveImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            print("ERROR SAVING IMAGE")
        }else {
            showToast(message: "MEME_SVD".localised)
        }
    }
    
    @objc func shareMeme(){
        // set up activity view controller
        let imageToShare = [ finalImage! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func setUpViews() {
        let deviceSize = UIScreen.main.bounds
        let deviceWidth = deviceSize.width
        let deviceHeight = deviceSize.height
        
        finalMemeImage.image = finalImage
        
        finalMemeView.addSubview(finalMemeImage)
        finalMemeView.addSubview(titileLabel)
        finalMemeView.addSubview(memeTitle)
        myScrollView.addSubview(finalMemeView)
        myScrollView.addSubview(saveMemeButton)
        myScrollView.addSubview(shareMemeButton)
        self.view.addSubview(myScrollView)
        
        _ = myScrollView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: deviceWidth, heightConstant: deviceHeight)
        
        _ = finalMemeView.anchor(myScrollView.topAnchor, left: myScrollView.leftAnchor, bottom: nil, right: myScrollView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: deviceWidth, heightConstant: deviceHeight-240)
        
        _ = finalMemeImage.anchor(finalMemeView.topAnchor, left: finalMemeView.leftAnchor, bottom: nil, right: finalMemeView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: deviceWidth, heightConstant: finalMemeView.frame.size.height-50)
        
        _ = titileLabel.anchor(finalMemeImage.bottomAnchor, left: finalMemeView.leftAnchor, bottom: finalMemeView.bottomAnchor, right: nil, topConstant: 8, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: deviceWidth/3, heightConstant: 30)
        
        _ = memeTitle.anchor(finalMemeImage.bottomAnchor, left: titileLabel.rightAnchor, bottom: finalMemeView.bottomAnchor, right: finalMemeView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: (2 * deviceWidth)/3, heightConstant: 30)
        
        _ = saveMemeButton.anchor(finalMemeView.bottomAnchor, left: myScrollView.leftAnchor, bottom: nil, right: myScrollView.rightAnchor, topConstant: 40, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: deviceWidth, heightConstant: 40)
        
        _ = shareMemeButton.anchor(saveMemeButton.bottomAnchor, left: myScrollView.leftAnchor, bottom: myScrollView.bottomAnchor, right: myScrollView.rightAnchor, topConstant: 20, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: deviceWidth, heightConstant: 40)
    }
}
