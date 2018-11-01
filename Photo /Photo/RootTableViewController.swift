//
//  RootTableViewController.swift
//  Photo
//
//  Created by 許雅筑 on 2016/9/19.
//  Copyright © 2016年 hsu.ya.chu. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController,DataEnteredDelegate,EditDataEnteredDelegate {


    
    struct everyPhoto {
        var topic:String? = ""
        var description:String? = ""
        var picture : UIImage?
        
    }
    
    var photosArray :[everyPhoto] = []
    var throwToEditPhoto: UIImage? = nil
    
//    @IBAction func save(segue:UIStoryboardSegue) {
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            self.tableView.reloadData()
//            
//        })
//        
//    }
    @IBAction func editSave(_ segue:UIStoryboardSegue) {
        DispatchQueue.main.async(execute: { () -> Void in
            self.tableView.reloadData()
            
        })
        
    }
    
    var chooseIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "myJournalsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        var everyPhoto1 = everyPhoto()
        everyPhoto1.picture = UIImage(named:"crossmap")
        everyPhoto1.topic = "test"
        photosArray.append(everyPhoto1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    func userDidEnterInformation(_ infoTopic: NSString,infoDescription: NSString,infoPicture:UIImage) {
    var photoObject = everyPhoto()
        photoObject.topic = infoTopic as String
        photoObject.description = infoDescription as String
        photoObject.picture = infoPicture
        
        self.photosArray.append(photoObject)
        print(photosArray)

        DispatchQueue.main.async(execute: { () -> Void in
            self.tableView.reloadData()
            
        })

    }
    func userEditEnterInformation(_ infoTopic: NSString,infoDescription: NSString,infoPicture:UIImage) {
        var photoObject = everyPhoto()
        photoObject.topic = infoTopic as String
        photoObject.description = infoDescription as String
        photoObject.picture = infoPicture
        self.photosArray.remove(at: chooseIndex)
        print("-------------------------")
        print(photosArray)
        self.photosArray.insert(photoObject, at: chooseIndex)
//        self.photosArray.append(photoObject)
//        print(photosArray)
        DispatchQueue.main.async(execute: { () -> Void in
            self.tableView.reloadData()
            
        })
    
    }
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photosArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let cellIdentifier = "Cell"
        let cell: myJournalsCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! myJournalsCell
        cell.beautifulPhoto?.image = photosArray[indexPath.row].picture
        throwToEditPhoto = photosArray[indexPath.row].picture
        cell.beautifulPhotoTopic?.text = photosArray[indexPath.row].topic
//        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(RootTableViewController.imageTapped(_:)))
//        cell.beautifulPhoto!.userInteractionEnabled = true
//        cell.beautifulPhoto!.addGestureRecognizer(tapGestureRecognizer)

//        cell.mapButton.addTarget(self, action: #selector(ViewController.MapBtnClicked), forControlEvents: .TouchUpInside)
        
        return cell

    }
    
    var tranferTopic = ""
    var tranferDescription = ""
    var tranferPicture:UIImage? = nil
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tranferTopic = photosArray[indexPath.row].topic!
        tranferDescription = photosArray[indexPath.row].description!
        tranferPicture = photosArray[indexPath.row].picture
        self.performSegue(withIdentifier: "editPhoto", sender:self)
        
        chooseIndex = indexPath.row
        print(chooseIndex)

    }
    
//    func imageTapped(img: AnyObject)
//    {
//        
//        self.performSegueWithIdentifier("editPhoto", sender:self)
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "showNewPhoto" {
            let destinationViewController = segue.destination as? NewPhotoViewController
            destinationViewController!.delegate = self
        }
        else if segue.identifier == "editPhoto" {
            let destinationViewController = segue.destination as? EditPhotoViewController

            destinationViewController!.editTranferPicture = tranferPicture
            destinationViewController!.editTranferTopic = tranferTopic
            destinationViewController!.editTranferDescription = tranferDescription
            destinationViewController!.delegate = self
        }
        
    }



}
