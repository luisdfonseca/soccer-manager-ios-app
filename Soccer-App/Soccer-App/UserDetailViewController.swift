//  PROGRAMMER:     Michael Juarez, Luis Daniel Fonseca
//  PANTHERID:      1316430
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     Final Project
//  DUE:            Thursday 12/08/16
//

import CoreData
import UIKit

class UserDetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    @IBOutlet weak var navbarItem: UINavigationItem!
    
    @IBOutlet weak var playerImg: UIImageView!
    
    var image = UIImage()
    var index : Int = 0
    let playerstore = PlayerStore.sharedInstance
    var thePlayer : Player = Player(playerNumber: "", firstName: "", lastName: "", phoneNumber: "", age: "", email: "", address: "", height: "", weight: "", birthdate: "")
    
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
        
        //Load text fields with information
        loadPlayerProperties()
        
        //Load the player's picture into the image
        image = playerstore.getPlayerImage(index)
        
        //Get the player for the row selected
        thePlayer = playerstore.getPlayer(self.index)
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
        
        //Update the image with whatever is stored in global 'image' variable
        playerImg.image = image
    }
    
    //Loads the text fields with the player selected
    func loadPlayerProperties(){
        
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
        
        navbarItem.title = thePlayer.firstName + " " + thePlayer.lastName
    }
    
    
    @IBAction func saveButton(sender: AnyObject) {
        
        // If player number is the same, then update
        if self.playerNumber.text == thePlayer.playerNumber {
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
            
            playerstore.savePicture(image, player: thePlayer)
            playerstore.updatePlayer(self.index, player: thePlayer)
            
            performSegueWithIdentifier("back2PlayersSegue", sender: self)
        }
        
        // At this point, player number has changed, so check if it already exists, if it doesn't then proceed forward
        else if !playerstore.checkPNumExists(self.playerNumber.text!) {
            
            
            
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
        
            playerstore.savePicture(image, player: playerstore.getPlayer(index))
            playerstore.updatePlayer(self.index, player: thePlayer)
            
            performSegueWithIdentifier("back2PlayersSegue", sender: self)
        }
        
        //The player number exists, blast user with message saying you can't use the same Jersey Number as another play
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
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        playerImg.image = image
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    

        
}


