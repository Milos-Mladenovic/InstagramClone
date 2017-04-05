//
//  PostViewController.swift
//  InstagramClone
//
//  Created by Milos Mladenovic on 4/5/17.
//  Copyright © 2017 Milos Mladenovic. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var imageToPost: UIImageView!
    
    @IBAction func chooseAnImage(_ sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageToPost.image = image
            
            } else{
            
                print("Something went wrong")

        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet var messageTextField: UITextField!
    @IBAction func postImage(_ sender: AnyObject) {
        
        let post = PFObject(className: "Posts")
        
        post["message"] = messageTextField.text
        
        post["userid"] = PFUser.current()?.objectId!
        
        let imageData = UIImageJPEGRepresentation(imageToPost.image!, 1)
        
        let imageFile = PFFile(name: "image.jpeg", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackground { (success, error) in
            
            UIApplication.shared.endIgnoringInteractionEvents() // UIApplication.shared() is now UIApplication.shared
            
            if error != nil {
                
                self.createAlert(title: "Could not post image", message: "Please try again later")
                
            } else {
                
                self.createAlert(title: "Image Posted!", message: "Your image has been posted successfully")
                
                self.messageTextField.text = ""
                
                self.imageToPost.image = UIImage(named: "mountine.jpeg")
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
