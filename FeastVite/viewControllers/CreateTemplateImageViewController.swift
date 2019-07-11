//
//  CreateTemplateImageViewController.swift
//  FeastVitePOC
//
//  Created by student on 6/14/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class CreateTemplateImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    static var shared:CreateTemplateImageViewController!
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var imagePreviewIV: UIImageView!
    @IBOutlet weak var previewTemplateBTN: UIButton!
    @IBOutlet weak var uploadImageBTN: UIButton!
    @IBOutlet weak var eventTypeTF: UITextField!
    @IBOutlet weak var personalMessageTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var venueTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImageBTN.layer.cornerRadius = 5
        previewTemplateBTN.layer.cornerRadius = 5
        imagePreviewIV.layer.cornerRadius = 3
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func uploadImageBTN(_ sender: Any) {
        let alert = UIAlertController(title: "Racecap", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Choose from photos", style: .default , handler:{ (UIAlertAction)in
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Take a picture", style: .default , handler:{ (UIAlertAction)in
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
        }))
        alert.popoverPresentationController?.sourceView = self.imagePreviewIV.inputView
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePreviewIV.image = image
         
        } else{
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }

    /**
     * Created by Pradeep Kolli
     
     * This method is used to fetch the details from the text fields in UI to create a event object.
     
     * @param  nil
     
     */
    func fetchEventDetailsFromTF() -> EventModel{
        let eventObj:EventModel = EventModel.shared
        eventObj.eventType = eventTypeTF.text!
        eventObj.address = addressTF.text!
        eventObj.dateAndTime = dateTF.text!
        eventObj.personalMessage = personalMessageTF.text!
        eventObj.phone = phoneTF.text!
        eventObj.venue = venueTF.text!
        return eventObj
    }
    
    /**
     * Created by Pradeep Kolli
     
     * This method is used to encode the final image we get after printing event details on it into a string of line length 64
     
     * @param  {UIImage} baseImage      [This param sends the baseImage to be encoded to the method]
     
     */
    func encodeToBase64String(fromImage:UIImage) -> String{
        //Now use image to create into NSData format
        let imageData:Data = fromImage.pngData()!
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
    /**
     * Created by Pradeep Kolli
     
     * This method is used to decode the base64 encoded String into a UIImage
     
     * @param  {String} fromString      [This param sends the base64 encoded String to be deocded to the method]
     
     */
    func decodeToImage(fromString:String) -> UIImage{
        let dataDecoded:Data = Data(base64Encoded: fromString, options: .ignoreUnknownCharacters)!
        let decodedimage:UIImage = UIImage(data: dataDecoded)!
        return decodedimage
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "previewImage"){
            let previewController = segue.destination as! PreviewViewController
            let imageSample = previewController.addTextToImage(eventDetails: fetchEventDetailsFromTF(), inImage: imagePreviewIV.image!, atPoint: CGPoint(x: 50, y: 50))
            previewController.imageText = imageSample
        }
    }
    
    /**
     * Created by Pradeep Kolli
     
     * This method is used to save the template to the Data store of backendless
     
     * @param  defaukt sender of type Any
     
     */
    @IBAction func saveActionBTN(_ sender: Any) {
        let templateObj = TemplateModel()
        let eventObj = EventModel()
        let pc:PreviewViewController = PreviewViewController()
        let imageWithDetails = pc.addTextToImage(eventDetails: fetchEventDetailsFromTF(), inImage: imagePreviewIV.image!, atPoint: CGPoint(x: 50, y: 50))
        let encodedImage = self.encodeToBase64String(fromImage: imageWithDetails)
        eventObj.eventType = eventTypeTF.text!
        eventObj.dateAndTime = dateTF.text!
        eventObj.venue = venueTF.text!
        eventObj.personalMessage = personalMessageTF.text!
        eventObj.address = addressTF.text!
        eventObj.phone = phoneTF.text!
        EventModelManager.shared.addEvent(event: eventObj)
        print("Crossed add event method")
//        templateObj.event = eventObj
        templateObj.templateImage = encodedImage
        templateObj.templateName = "temp"
        TemplateModelManager.shared.addTemplate(template: templateObj)
        print("Crossed add template method")

    }
    
}




