//
//  NewPhotoViewController.swift
//  Photo
//
//  Created by 許雅筑 on 2016/9/19.
//  Copyright © 2016年 hsu.ya.chu. All rights reserved.
//

import UIKit
protocol DataEnteredDelegate {
    func userDidEnterInformation(_ infoTopic:NSString,infoDescription:NSString,infoPicture:UIImage)
}

class NewPhotoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var imageview: UIImageView!
    let imagePicker = UIImagePickerController()

    
    @IBOutlet var save: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet var topicTextField: UITextField! = UITextField()
    @IBOutlet var descriptionTextField: UITextView! = UITextView()
    
    var delegate:DataEnteredDelegate? = nil
    
    @IBAction func loadImageButton(_ sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(NewPhotoViewController.imageTapped(_:)))
        imageview!.isUserInteractionEnabled = true
        imageview!.addGestureRecognizer(tapGestureRecognizer)

    }
    @objc func imageTapped(_ img: AnyObject)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageview.contentMode = .scaleAspectFit
            imageview.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveData(_ sender: AnyObject) {
        if (delegate != nil){
            let information:NSString = topicTextField.text! as NSString
            
            let descriptionInformation:NSString = descriptionTextField.text as! NSString
            delegate!.userDidEnterInformation(information,infoDescription: descriptionInformation,infoPicture:imageview.image!)
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)

    }



}
