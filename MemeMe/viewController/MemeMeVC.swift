//
//  ViewController.swift
//  MemeMe
//
//  Created by Julien Laurent on 11/21/20.
//

import UIKit

class MemeMeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var memeMeImage: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTexField: UITextField!
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendButton.isEnabled = false
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        setAttributesForMemeText(textField: topTextField, placeHolderText: K.topTextPlaceHolder)
        setAttributesForMemeText(textField: bottomTexField, placeHolderText: K.bottomTextPlaceHolder)
        view.backgroundColor = .darkGray
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //this line of code snippet is credited to Udacity
        //source: lesson 4 code for keyboard adjustemet
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageForMeme = info[.originalImage] as? UIImage{
            sendButton.isEnabled = true
            memeMeImage.image = imageForMeme
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //just to catch user's attention
    func errorAlert(title: String, message: String){
        let alertController = UIAlertController()
        alertController.title = title
        alertController.message = message
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func saveMeme(memeMeMade: UIImage) {
        if let imageview = self.memeMeImage.image, let topText = self.topTextField.text, let bottomText = self.bottomTexField.text{
            let thisMeme = Meme(topText: topText, bottomText: bottomText, image: imageview, memeImage: memeMeMade)
            //-Mark save the meme here using the meme struck,
            //however no instruction were provided on how to save it
            addMemeToList(meme: thisMeme)
        }
    }
    
    func addMemeToList(meme: Meme) {
        let appDelegateObject = UIApplication.shared.delegate as! AppDelegate
        appDelegateObject.memeMes.append(meme)
    }
    
    @IBAction func actionPerformedButtonPressed(_ sender: UIBarButtonItem) {
        switch actionPerform(rawValue: sender.tag) {
        case .cancel:
            memeMeImage.image = nil
            topTextField.text = K.topTextPlaceHolder
            bottomTexField.text = K.bottomTextPlaceHolder
            sendButton.isEnabled = false
            self.dismiss(animated: true, completion: nil)
            navigationController?.popToRootViewController(animated: true)
        case .send:
            let memeMeMade = makeMeme()
            let uiActivityController = UIActivityViewController(activityItems: [memeMeMade], applicationActivities: nil)
            uiActivityController.completionWithItemsHandler = {(_,success,_,_) in
                if success {
                    self.saveMeme(memeMeMade: memeMeMade)
                    self.errorAlert(title: "Success", message: "Your Meme was sent Successfully")
                }
            }
            present(uiActivityController, animated: true, completion: nil)
        default:
            print("Unknow action")
        }
    }
}

extension MemeMeVC: UITextFieldDelegate{
    
    //to set the attributes of the top and bottom textfield
    func setAttributesForMemeText(textField: UITextField, placeHolderText: String){
        let textAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: K.textFont, size: CGFloat(K.textSize))!,
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeWidth: -5.0
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
    
    //fuction use to generate the meme after modification
    //credited to Udacity
    func makeMeme()->UIImage{
        
        hideTheToolbars(isToolbarHiden: true)//toobar will he hidden her
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideTheToolbars(isToolbarHiden: false) //toolbar will be shown here
        return image
    }
    
    
    //function to hide the toolbar
    func hideTheToolbars(isToolbarHiden: Bool){
        if isToolbarHiden{
            topToolBar.isHidden = true
            bottomToolBar.isHidden = true
        }else{
            topToolBar.isHidden = false
            bottomToolBar.isHidden = false
        }
    }
}

