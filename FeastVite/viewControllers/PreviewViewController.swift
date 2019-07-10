//
//  PreviewViewController.swift
//  FeastVitePOC
//
//  Created by student on 6/14/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit
extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }
        
        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }
        
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0
        
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}
class PreviewViewController: UIViewController {

    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    let templateObject = Template.shared
    @IBOutlet weak var previewImg: UIImageView!
    var label:UILabel!
    var imageDummy:UIImage = UIImage(named: "bg")!
    var imageText:UIImage!
    var totalDetails:NSString?
    var frameSizeHeight:CGFloat = 0
    var frameSizeWidth:CGFloat = 0
    var imageRectExtOut:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
//    var dummyData =
        override func viewDidLoad() {
        super.viewDidLoad()
//            previewImg.set = imageText.size.width
//            previewImg.frame.height = imageText.size.height
//            imageText = addTextToImage(text: totalDetails!, inImage: imageDummy, atPoint: CGPoint(x: 20, y: 20))
            previewImg.image = imageText
            frameSizeWidth = previewImg.frame.width
            frameSizeHeight = previewImg.frame.height
            imageRectExtOut = previewImg.contentClippingRect
            print("previewImage text : \(imageRectExtOut.size.height)")
            

    }
    
    
    func addTextToImage(eventDetails: [Template], inImage: UIImage, atPoint:CGPoint) -> UIImage{
//       label.drawText(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        // Setup the font specific variables
        let textColor = UIColor.white
        let textFont = UIFont(name: "HelveticaNeue", size: 500)
        
        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ]
        
        // Create bitmap based graphics context
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, 0.0)
        
        
        //Put the image into a rectangle as large as the original image.
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        // Our drawing bounds
        let drawingBounds = CGRect(x:0.0, y:0.0, width:inImage.size.width, height:inImage.size.height)

            let text1 = eventDetails[0].eventType as NSString
            let textSize = text1.size(withAttributes: [NSAttributedString.Key.font:textFont])
            let textRect = CGRect(x:drawingBounds.size.width/2 - textSize.width/2, y: imageRectExtOut.size.height,
                                  width:textSize.width, height:textSize.height)
            text1.draw(in: textRect, withAttributes: textFontAttributes)

       
        
        // Get the image from the graphics context
        let newImag = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImag!
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
