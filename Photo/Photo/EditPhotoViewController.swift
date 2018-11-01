//
//  EditPhotoViewController.swift
//  Photo
//
//  Created by 許雅筑 on 2016/9/19.
//  Copyright © 2016年 hsu.ya.chu. All rights reserved.
//

import UIKit



protocol EditDataEnteredDelegate {
    func userEditEnterInformation(_ infoTopic:NSString,infoDescription:NSString,infoPicture:UIImage)
}

class EditPhotoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //負責接收
    var editTranferPicture:UIImage?
    var editTranferTopic:String = ""
    var editTranferDescription:String = ""    
    
        @IBOutlet var editImageView: UIImageView!
    let imagePicker = UIImagePickerController()

    @IBOutlet var editSave: UIButton!
    @IBOutlet var editTopicTextField: UITextField! = UITextField()
    
    @IBOutlet var editDescriptionTextField: UITextView! = UITextView()
    var delegate:EditDataEnteredDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        editImageView.image = editTranferPicture
        editTopicTextField.text = editTranferTopic
        editDescriptionTextField.text = editTranferDescription

        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(EditPhotoViewController.imageTapped(_:)))
        editImageView!.isUserInteractionEnabled = true
        editImageView!.addGestureRecognizer(tapGestureRecognizer)

        
        
    }
    
    func imageTapped(_ img: AnyObject)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            editImageView.contentMode = .scaleAspectFit
            editImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveData(_ sender: AnyObject) {
        if (delegate != nil){
            let information:NSString = editTopicTextField.text! as NSString
            
            let descriptionInformation:NSString = editDescriptionTextField.text as! NSString
            
            delegate!.userEditEnterInformation(information,infoDescription: descriptionInformation,infoPicture:editImageView.image!)
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
