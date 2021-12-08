//
//  CameraViewController.swift
//  SUChemistryiOSApp
//

import AVFoundation
import UIKit

class CameraViewController: UIViewController, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
@IBOutlet weak var imageView: UIImageView!

    //Sample drop down menu
    @IBOutlet weak var textBox: UITextField!
    
    @IBOutlet weak var dropDown: UIPickerView!
    
    var list = ["Sample One", "Sample Two", "Sample Three", "Sample Four", "Sample Five"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1

    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

        return list.count

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
        return list[row]

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        self.textBox.text = self.list[row]
        self.dropDown.isHidden = true

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.textBox {
            self.dropDown.isHidden = false

            textField.endEditing(true)
        }

    }
    
    
    let imagePicker = UIImagePickerController()
    
    var sample = SampleData()
    let control = SampleData()
    
    //Labels for data from camera
    var labelRed = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 600))
    var labelGreen = UILabel(frame: CGRect(x: 0, y: 20, width: 1000, height: 600))
    var labelBlue = UILabel(frame: CGRect(x: 0, y: 40, width: 1000, height: 600))
    var labelIntensity = UILabel(frame: CGRect(x: 0, y: 60, width: 1000, height: 600))
    var labelAbsorbance = UILabel(frame: CGRect(x: 0, y: 80, width: 1000, height: 600))
    var labelColorName = UILabel(frame: CGRect(x: 0, y: 100, width: 1000, height: 600))
    var labelWavelengthValue = UILabel(frame: CGRect(x: 0, y: 120, width: 1000, height: 600))

 

 //Camera Button
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

    //called after a picture is taken, before session is stopped
    //labels defined here are refreshed with new data and displayed
    override func viewWillAppear(_ animated: Bool) {
        labelRed.text = "Red: \(sample.getRedValue())";
        labelGreen.text = "Green: \(sample.getGreenValue())";
        labelBlue.text = "Blue: \(sample.getBlueValue())";
        labelIntensity.text = String(format: "Intensity: %.0f", sample.getIntensity())
        labelAbsorbance.text = String(format: "Absorbance: %.2f", sample.getAbsorbanceValue())
        labelColorName.text = "Color name: \(sample.getColorName())";
        labelWavelengthValue.text = "Wavelength range: \(sample.getWavelengthValue())";
        view.addSubview(labelRed)
        view.addSubview(labelGreen)
        view.addSubview(labelBlue)
        view.addSubview(labelIntensity)
        view.addSubview(labelAbsorbance)
        view.addSubview(labelColorName)
        view.addSubview(labelWavelengthValue)
    }

    //populates sample with data from the camera
    //call after taking a photo of either a sample or control
    func fillSampleDataObject(image:UIImage) -> SampleData {
        let (red, green, blue) = calculateRGB(image:image)
        sample.setRedValue(redValue:red)
        sample.setGreenValue(greenValue:green)
        sample.setBlueValue(blueValue:blue)
        
        let intensity = (Double)(red + green + blue)
        sample.setIntensity(intensity:intensity)
        
        sample.calculateColorName()
        sample.calculateWavelengthValue()

        return sample
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
