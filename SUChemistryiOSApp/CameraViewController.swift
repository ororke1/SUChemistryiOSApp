//
//  CameraViewController.swift
//  SUChemistryiOSApp
//
import AVFoundation
import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
@IBOutlet weak var imageView: UIImageView!

let imagePicker = UIImagePickerController()

override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    imagePicker.delegate = self
    imagePicker.allowsEditing = true

}

    @IBAction func toGraph(_ sender: Any) {
        performSegue(withIdentifier: "segueToGraph", sender: self)
    }
    
@IBAction func didTapAddPhotoButton(_ sender: Any) {
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (button) in
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }))
    
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (button) in
        self.imagePicker.sourceType = .camera
        self.present(self.imagePicker, animated: true, completion: nil)
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    present(alert, animated: true, completion: nil)
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
    imageView.image = pickedImage

            
            let (red, green, blue) = calculateRGB(image: pickedImage)
            print(red)
            print(green)
            print(blue)
    dismiss(animated: true, completion: nil)
    
            
    
}


/**
 * Calculates the average red, green, and blue values of pixels in a given image
 * @param image: UIImage - the image to be analyzed
 * @return (red, green, blue) - a triplet of the average red, green, and blue values, respectively
 * @author Olivia Rorke
 */
func calculateRGB(image:UIImage) -> (red: Int, green: Int, blue: Int) {
    
    guard let cgImage = image.cgImage,
          let cgData = cgImage.dataProvider?.data,
          let cgBytes = CFDataGetBytePtr(cgData) else {
        return (0, 0, 0)
    }
    let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent
    var red, green, blue: Int
    red = 0
    green = 0
    blue = 0
    
    let totalPixels = cgImage.width * cgImage.height
    
    for x in 0 ..< cgImage.width {
        for y in 0 ..< cgImage.height {
            let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
            
            red += Int(cgBytes[offset])
            green += Int(cgBytes[offset + 1])
            blue += Int(cgBytes[offset + 2])
        }
    }
    
    return (red / totalPixels, green / totalPixels, blue / totalPixels)
}

}
