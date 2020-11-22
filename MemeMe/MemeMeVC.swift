//
//  ViewController.swift
//  MemeMe
//
//  Created by Julien Laurent on 11/21/20.
//

import UIKit

enum imageSource: Int{
    case camera = 0
    case albumn
}

class MemeMeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    
    @IBOutlet weak var memeMeImage: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTexField: UITextField!
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.isEnabled = false
        //cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        
        setAttributesForMemeText(textField: topTextField, placeHolderText: K.topTextPlaceHolder)
        setAttributesForMemeText(textField: bottomTexField, placeHolderText: K.bottomTextPlaceHolder)
        view.backgroundColor = .darkGray
       
    }

    
    @IBAction func pickImageButtonPressed(_ sender: UIBarButtonItem) {
        switch imageSource(rawValue: sender.tag) {
        case .camera:
            let imagePickerSourceType = UIImagePickerController.SourceType.camera
            pickImage(imageSourceType: imagePickerSourceType)
        case .albumn:
            let imagePickerSourceType = UIImagePickerController.SourceType.photoLibrary
                pickImage(imageSourceType: imagePickerSourceType)
        default:
            print("Unknown choice")
        }
    }
    
    //use to display the Image picker controller (camera | photolibrary)
    func pickImage(imageSourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        print(imagePicker.sourceType.rawValue)
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(imageSourceType) {
            imagePicker.sourceType = imageSourceType
            present(imagePicker, animated: true, completion: nil)
        }else{
            errorAlert(title: "Error", message: "This Source is not availlable")
        }
        
    }
    
    //to catch the user's attention when
    //an error happen
    func errorAlert(title: String, message: String){
        let alertController = UIAlertController()
        alertController.title = title
        alertController.message = message
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sendButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    }
    
}

extension MemeMeVC: UITextFieldDelegate{
    
    //to set the attributes of the top and bottom textfield
    func setAttributesForMemeText(textField: UITextField, placeHolderText: String){
        let textAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeColor: UIColor.white,
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.strokeWidth: 5.0
        ]
        textField.text = placeHolderText
        textField.defaultTextAttributes = textAttributes
        textField.autocapitalizationType = .allCharacters
        textField.textAlignment = .center
        textField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == K.topTextPlaceHolder || textField.text == K.bottomTextPlaceHolder{
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   
}

extension MemeMeVC{
    
}

