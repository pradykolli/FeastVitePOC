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
    static var templateObject = Template.shared
    static var totalDetails:String = ""
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

    func templateView() -> [Template]{
        CreateTemplateImageViewController.templateObject.address = addressTF.text!
        CreateTemplateImageViewController.templateObject.date = dateTF.text!
        CreateTemplateImageViewController.templateObject.eventType = eventTypeTF.text!
        CreateTemplateImageViewController.templateObject.personalMessage = personalMessageTF.text!
        CreateTemplateImageViewController.templateObject.phone = phoneTF.text!
        CreateTemplateImageViewController.templateObject.venue = venueTF.text!
       let eventData = self.addEventDetails(event: CreateTemplateImageViewController.templateObject)
        return eventData
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "previewImage"){
            let previewController = segue.destination as! PreviewViewController
            let imageSample = previewController.addTextToImage(eventDetails: templateView(), inImage: imagePreviewIV.image!, atPoint: CGPoint(x: 50, y: 50))
            previewController.imageText = imageSample
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    _ adderss:String, _ personalMessage:String, _ date:String, _ phone:String, _ venue:String, _ eventType:String

    func addEventDetails(event:Template) -> [Template]{
        var eventData:[Template] = []
        eventData.append(event)
        return eventData
    }
    
}

class Template{
    private static var _shared:Template!
    static var shared:Template{
        if _shared == nil {
            _shared = Template()
        }
        return _shared
    }
    var eventType: String
    var personalMessage: String
    var address: String
    var phone: String
    var venue: String
    var date: String
    private init(){
        self.address = ""
        self.date = ""
        self.eventType = ""
        self.personalMessage = ""
        self.phone = ""
        self.venue = ""
    }
}


