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
        sendButton.isEnabled = false
        //cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        setAttributesForMemeText(textField: topTextField, placeHolderText: K.topTextPlaceHolder)
        setAttributesForMemeText(textField: bottomTexField, placeHolderText: K.bottomTextPlaceHolder)
        view.backgroundColor = .darkGray
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //this line of code snippet is credited to Udacity
        //source: lesson 4 code for keyboard adjustemet
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //this line of code snippet is credited to Udacity
        //source: lesson 4 code for keyboard adjustemet
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //this snippet of code is also credited to stackoverflow.com
    //because I was unable to use the one provided by
    //udacity correctly
    //source: https://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
    @objc func keyboarWillShow(_ notification: Notification){
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if view.frame.origin.y == 0 && bottomTexField.isFirstResponder{
                self.view.frame.origin.y -= keyboardHeight.height
            }
        }
    }

    
    @objc func keyboardWillHide(_ notification: Notification) {
        if view.frame.origin.y != 0 && bottomTexField.isFirstResponder{
            view.frame.origin.y = 0
        }
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
            memeMeImage.image = nil
            topTextField.text = K.topTextPlaceHolder
            bottomTexField.text = K.bottomTextPlaceHolder
            self.dismiss(animated: true, completion: nil)
        case .send:
            print("send")
        default:
            print("Unknow action")
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func generatedMemeImage()->UIImage{
        self.
    }
}

