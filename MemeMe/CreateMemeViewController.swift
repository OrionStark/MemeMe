//
//  CreateMemeViewController
//  MemeMe
//
//  Created by Robby Muhammad Nst on 14/10/18.
//  Copyright © 2018 ORIONOSCODE. All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextField(topTextField)
        setUpTextField(bottomTextField)
        refreshView()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if ( bottomTextField.isEditing ) {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    /* MARK: -This is the function to take image from album */
    @IBAction func pickImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        shareButton.isEnabled = false
    
        // Create the meme
        let _memeImage = generateMemeImage()
        let activityViewController = UIActivityViewController(activityItems: [_memeImage], applicationActivities: [])
        activityViewController.completionWithItemsHandler = {
            (activity, completed, items, error) in
            if ( completed ) {
                self.save(_memeImage)
            }
        }
        present(activityViewController, animated: true, completion: nil)
        shareButton.isEnabled = true
    }
    
    /* MARK: After meme succesfully saved, this method will be called */
    func save(_ memedImage: UIImage) {
        
        /* Save meme to the shared data */
        let meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, originalImage: imageView.image, finalImage: memedImage)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        /* After meme saved, show the alert for succeed saving the meme. */
        let alert = UIAlertController(title: "Save Completed", message: "Your meme has been saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.refreshView()
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        refreshView()
        dismiss(animated: true, completion: nil)
    }
    
    func refreshView() {
        topTextField.text = "TOP TEXT"
        bottomTextField.text = "BOTTOM TEXT"
        imageView.image = nil
        shareButton.isEnabled = false
    }
    
    /* MARK: Setup text atributes to the textfield */
    func setUpTextField(_ textField: UITextField) {
        let memeTextAttributes:[String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -3.5]
        textField.defaultTextAttributes = memeTextAttributes
        textField.delegate = self
    }
    
    /* MARK: - Get the image and show it to the imageview */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    /* MARK: Generate the meme */
    func generateMemeImage() -> UIImage {
        toggleToolBarandNavbar(state: true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeResult: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        toggleToolBarandNavbar(state: false)
        return memeResult
    }
    
    /* Change the toolbar and navbar state for hide or show */
    func toggleToolBarandNavbar(state: Bool) {
        navbar.isHidden = state
        toolbar.isHidden = state
    }
    
    
}

