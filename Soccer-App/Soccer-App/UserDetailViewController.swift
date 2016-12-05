//
//  UserDetailViewController.swift
//  Soccer-App
//
//  Created by michael jason juarez on 12/2/16.
//  Copyright © 2016 luis daniel fonseca. All rights reserved.
//

import CoreData
import UIKit

class UserDetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    enum error: ErrorType {
        case bad
    }
    
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var playerNumber: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var birthdate: UITextField!
    
    @IBOutlet weak var navBar: UINavigationBar!

    @IBOutlet weak var playerImg: UIImageView!
    
    var image = UIImage()
    var index : Int = 0
    let playerstore = PlayerStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fName.delegate = self;
        self.lName.delegate = self;
        self.playerNumber.delegate = self;
        self.phoneNumber.delegate = self;
        self.age.delegate = self;
        self.email.delegate = self;
        self.address.delegate = self;
        self.height.delegate = self;
        self.weight.delegate = self;
        self.birthdate.delegate = self;
        // Do any additional setup after loading the view.
        
        playerImg.image = playerstore.getPlayerImage(index)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadPlayerProperties()
    }

    func loadPlayerProperties(){
        
        let thePlayer : Player = playerstore.getPlayer(self.index)
        
        self.fName.text = thePlayer.firstName
        self.lName.text = thePlayer.lastName
        self.playerNumber.text = thePlayer.playerNumber
        self.phoneNumber.text = thePlayer.phoneNumber
        self.age.text = thePlayer.age
        self.email.text = thePlayer.email
        self.address.text = thePlayer.address
        self.height.text = thePlayer.height
        self.weight.text = thePlayer.weight
        self.birthdate.text = thePlayer.birthdate
        
        self.title = thePlayer.firstName + " " + thePlayer.lastName        
    }
    
    
    @IBAction func saveButton(sender: AnyObject) {
        
        var thePlayer : Player = Player(playerNumber: "", firstName: "", lastName: "", phoneNumber: "", age: "", email: "", address: "", height: "", weight: "", birthdate: "")
        
        if !playerstore.checkPNumExists(self.playerNumber.text!) {
       
            thePlayer.firstName = self.fName.text!
            thePlayer.lastName = self.lName.text!
            thePlayer.playerNumber = self.playerNumber.text!
            thePlayer.phoneNumber = self.phoneNumber.text!
            thePlayer.age = self.age.text!
            thePlayer.email = self.email.text!
            thePlayer.address = self.address.text!
            thePlayer.height = self.height.text!
            thePlayer.weight = self.weight.text!
            thePlayer.birthdate = self.birthdate.text!
        
            playerstore.updatePlayer(self.index, player: thePlayer)
        
            performSegueWithIdentifier("back2PlayersSegue", sender: self)
        }
        else{
            let instructionAlert: UIAlertController = UIAlertController(title: "Number Already Exists", message: "Sorry, this number is already assigned to another player.", preferredStyle: .Alert)
            instructionAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(instructionAlert, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    @IBAction func pressedCamera(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
            imagePicker.allowsEditing = true
            imagePicker.cameraCaptureMode = .Photo  // or .Video
            imagePicker.modalPresentationStyle = .FullScreen
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
    } // end pressedCamera
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        playerstore.savePicture(image, index: index)
        
        playerImg.image = image
        
        dismissViewControllerAnimated(true, completion: nil)
        
    } // end imagePickerController (_:didFinish)
    
    

        
}


