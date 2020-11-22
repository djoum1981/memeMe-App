//
//  ViewController.swift
//  MemeMe
//
//  Created by Julien Laurent on 11/21/20.
//

import UIKit



class MemeMeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    
    @IBOutlet weak var memeMeImage: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTexField: UITextField!
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sendButton.isEnabled = false
        //cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        
        setAttributesForMemeText(textField: topTextField, placeHolderText: K.topTextPlaceHolder)
        setAttributesForMemeText(textField: bottomTexField, placeHolderText: K.bottomTextPlaceHolder)
        view.backgroundColor = .darkGray
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyBoardNorfication()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        
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
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(imageSourceType) {
            imagePicker.sourceType = imageSourceType
            present(imagePicker, animated: true, completion: nil)
        }else{
            errorAlert(title: "Stop", message: "The selected image source is not availlable on this device")
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
    
    @IBAction func actionPerformedButtonPressed(_ sender: UIBarButtonItem) {
        switch actionPerform(rawValue: sender.tag) {
        case .cancel:
            print("cancel")
        case .send:
            print("send")
        default:
            print("Unknow aciton")
        }
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
    
   /*
     this section of the project to show/hide the keyboard is credited to internet research
     ass I could not have the Udacity's provided code snippet to work correctly
     sources: 1-  https://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
                2- https://fluffy.es/move-view-when-keyboard-is-shown/
     */
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    fileprivate func keyBoardNorfication() {
        NotificationCenter.default.addObserver(self, selector: #selector(MemeMeVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MemeMeVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
}

