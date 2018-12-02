//
//  ViewController.swift
//  Dank Memes
//
//  Created by Ruben on 28/07/18.
//  Copyright © 2018 Ruben. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var selectMeme: UIButton!
    
    @IBOutlet weak var gallery: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }
    
    //user clicks select meme button
    @IBAction func selectMemeButton(_ sender: UIButton) {
        let layout=UICollectionViewFlowLayout()
        let selectMeme = SelectMemeController(collectionViewLayout: layout)
        self.navigationController?.pushViewController(selectMeme, animated: true)
    }
    
    //user clicks on gallery button
    @IBAction func galleryButton(_ sender: UIButton) {
        //pick an image from the gallery
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageData = UIImagePNGRepresentation(pickedImage!) as NSData?
        UserDefaults.standard.set(true, forKey: "SelectedGalleryOrCameraImage")
        UserDefaults.standard.set(false, forKey: "SelectedMemeImage")
        UserDefaults.standard.set(imageData, forKey: "SelectedImage")
        dismiss(animated:true, completion: nil)
        let makeMeme = MakeMemeController()
        self.navigationController?.pushViewController(makeMeme, animated: true)
    }
    
//    func imagePickerController(picker : UIViewController!, didFinishPickingImage image : UIImage!, editingInfo : NSDictionary!){
//        self.dismiss(animated: true, completion: {() -> Void in
//        })
//        // got image
//        UserDefaults.standard.set(true, forKey: "SelectedGalleryImage")
//        UserDefaults.standard.set(image, forKey: "SelectedImage")
//    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
    
//    //when user clicks take photo button
//    @IBAction func takePhotoButton(_ sender: UIButton) {
//        print("Take Photo pressed")
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//        imagePicker.delegate = self
//        imagePicker.sourceType = .camera
//        imagePicker.allowsEditing = false
//
//        self.present(imagePicker, animated: true, completion: nil)
//        }
//    }
//
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI()  {
        self.titleLabel.text = "HOME_TITLE".localised
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        self.selectMeme.setTitle("APP_IMAGES".localised, for: .normal)
        self.selectMeme.setTitleColor(UIColor.white, for: .normal)
        self.selectMeme.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        self.selectMeme.layer.cornerRadius = 18
        self.selectMeme.clipsToBounds = true
        self.selectMeme.backgroundColor = Constants.buttonColor
        
        self.gallery.setTitle("GALLERY".localised, for: .normal)
        self.gallery.setTitleColor(UIColor.white, for: .normal)
        self.gallery.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        self.gallery.layer.cornerRadius = 18
        self.gallery.clipsToBounds = true
        self.gallery.backgroundColor = Constants.buttonColor
    }

}

