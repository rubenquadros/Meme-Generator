//
//  SelectMemeController.swift
//  Dank Memes
//
//  Created by Ruben on 12/08/18.
//  Copyright © 2018 Ruben. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SelectMemeController: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    var imageUrls:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor=UIColor.white
        getMyImages()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = "SELECT_MEME".localised
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func getMyImages(){
        let url = NSURL(string: "https://api.imgur.com/3/album/T8HtgII/images")!
        var request = URLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.setValue("Client-ID 6d780d53b5ed06c", forHTTPHeaderField: "Authorization")
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        session.dataTask(with: request,  completionHandler: {(data, response, error) in
            var jsonDict : NSDictionary?
            var jsonDict1 : NSDictionary?
            var jsonArray1 : NSArray?
            do{
                if data != nil{
                    do{
                        
                        jsonDict = try JSONSerialization.jsonObject(with: data as! Data, options: []) as?  NSDictionary
                    }catch{
                        
                        print(error)
                    }
                    let jsonArray = NSArray.init(object: (jsonDict?.object(forKey:"data"))!)
                    for index in 0...jsonArray.count-1{
                        
                        jsonArray1 = jsonArray[index] as? NSArray
                    }
                    
                    for i in 0...jsonArray1!.count-1{
                        
                        jsonDict1 = ((jsonArray1?.object(at: i)) as! NSDictionary)
                        self.imageUrls.append(jsonDict1?.object(forKey: "link") as! String)
                        DispatchQueue.main.async(){
                            self.collectionView?.reloadData()
                        }
                    }
                }
            }
        }).resume()
        print(self.imageUrls)
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageUrls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        cell.backgroundColor = UIColor.white
        DispatchQueue.global().async {
            let imageString = self.imageUrls[indexPath.row]
            let url = NSURL(string: imageString)
            let imageData = NSData(contentsOf: url! as URL)
            DispatchQueue.main.async {
                if(imageData != nil){
                    cell.myImageView.image = UIImage(data: imageData! as Data)
                }
            }
        }
        
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-16, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.set(true, forKey: "SelectedMemeImage")
        UserDefaults.standard.set(false, forKey: "SelectedGalleryOrCameraImage")
        UserDefaults.standard.set(self.imageUrls[indexPath.row], forKey: "SelectedImage")
        let makeMeme = MakeMemeController()
        self.navigationController?.pushViewController(makeMeme, animated: true)
    }
    
    func setUpViews() {
        //view.addSubview(myNavigation)
        if let flowlayout=collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowlayout.scrollDirection = .vertical
            flowlayout.minimumLineSpacing=10
        }
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.anchor(topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }

}
