//
//  CameraViewController.swift
//  SUChemistryiOSApp
//

import AVFoundation
import UIKit
import Charts

class CameraViewController: UIViewController, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
@IBOutlet weak var imageView: UIImageView!

    //Sample drop down menu
    @IBOutlet weak var textBox: UITextField!
    //Dropdown object
    @IBOutlet weak var dropDown: UIPickerView!
    //Dropdown options for samples
    var list = ["Control", "Sample One", "Sample Two", "Sample Three", "Sample Four", "Sample Five"]
    
    //Sample objects
    var currentSample = SampleData()
    var controlIntensity = 0.0
    
    //Arrange sample objects into an array
    var samples: [SampleData] = []
    
    //Display the current sample Name
    @IBOutlet weak var sampleNameField: UITextField!
    //Display the current sample concentration
    @IBOutlet weak var concentrationField: UITextField!
    //Display the current sample pathlength
    @IBOutlet weak var pathlengthField: UITextField!

    //Display the Red, Green, and Blue values of the current sample
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    //Display the absorbance, wavelength, and color of the current sample
    @IBOutlet weak var wavelengthLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var absorbanceLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        //Start at control
        dropDown.selectRow(0, inComponent: 0, animated: false)
        textBox.text = list[dropDown.selectedRow(inComponent: 0)]
        
        //Attempt to load any existing sample
        loadCurrent(selected: 0)
        
        //Update the screen
        update()
    }
    
    /**
     *Updates all UI Elements with the current sample info, or the approrpiate default info
     *Editied slightly from Luke's code
     */
     func update() {
        //Fill the name field if present
        sampleNameField.text = currentSample.sampleName
        
        //Fill the concentration and pathlength fields with decimal format
        concentrationField.text = String(format:"%.2f", currentSample.getConcentrationValue())
        pathlengthField.text = String(format: "%.2f", currentSample.getPathlengthValue())
        
        //Fill the rgb labels
        redLabel.text = "Red: \(currentSample.getRedValue())"
        greenLabel.text = "Green: \(currentSample.getGreenValue())"
        blueLabel.text = "Blue: \(currentSample.getBlueValue())"
        
        //Fill the wavelength labels
        colorLabel.text = currentSample.getColorName()
        wavelengthLabel.text = currentSample.getWavelengthValue()
        
        //Fill the absorbance label
        absorbanceLabel.text = String(format: "%.2f", currentSample.getAbsorbanceValue())
        
        //Update the image
        imageView.image = currentSample.imageData ?? UIImage(named: "defaultSampleImage/imageView")
    }
    
    /**
     *Saves the currentSample to the local file directory for persistency even between launches.
     *Format is: name | concentration | pathLength | red | green | blue | colorName | wavelength | intensity | imageData (as Base64 String)
     *where each field is separated by a newline character
     *@param selected: the currently selected sample
     */
    func saveCurrent(selected:Int) {
        let fileName = "sample\(selected)"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName)
        
        //Convert current sample to string
        var dataString = String()
        if(sampleNameField.text == "") {
            dataString.append("NONE*")
        } else {
            dataString.append(sampleNameField.text ?? "NONE*")
        }
        dataString.append("\n")
        if(concentrationField.text == "") {
            dataString.append("0.0")
        } else {
            dataString.append(concentrationField.text ?? "0.0")
        }
        dataString.append("\n")
        if(pathlengthField.text == "") {
            dataString.append("1.15")
        } else {
            dataString.append(pathlengthField.text ?? "1.15")
        }
        dataString.append("\n")
        dataString.append("\(currentSample.getRedValue())")
        dataString.append("\n")
        dataString.append("\(currentSample.getGreenValue())")
        dataString.append("\n")
        dataString.append("\(currentSample.getBlueValue())")
        dataString.append("\n")
        dataString.append(currentSample.colorName)
        dataString.append("\n")
        dataString.append("\(currentSample.getWavelengthValue())")
        dataString.append("\n")
        dataString.append("\(currentSample.getIntensity())")
        dataString.append("\n")
        dataString.append(currentSample.imageData?.jpegData(compressionQuality: 1)?.base64EncodedString() ?? "NONE*")
        
        do {
            try dataString.write(to:fileURL, atomically: true, encoding: .utf8)
            print("Saved data to: " + fileURL.absoluteString)
            if(selected == 0) {
                controlIntensity = currentSample.getIntensity()
            }
        } catch let error as NSError {
            print("Failed to save Data")
            print(error)
        }
    }
    
    /**
     *Loads the sample with given id into currentSample and then updates the UI to reflect the loaded data
     *If no data is found, default Sample Data is used instead
     *@param selected: the currently selected sample
     */
    func loadCurrent(selected:Int) {
        let fileName = "sample\(selected)"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName)
        
        do {
            let stringData = try String(contentsOf:fileURL, encoding: .utf8)
            let parsedData = stringData.split(whereSeparator: \.isNewline)
            if(parsedData[0] == "NONE*") {
                currentSample.sampleName = ""
            } else {
                currentSample.sampleName = String(parsedData[0])
            }
            currentSample.concentrationValue = Double(parsedData[1]) ?? 0.0
            currentSample.pathlengthValue = Double(parsedData[2]) ?? 1.15
            currentSample.redValue = Int(parsedData[3]) ?? 0
            currentSample.greenValue = Int(parsedData[4]) ?? 0
            currentSample.blueValue = Int(parsedData[5]) ?? 0
            currentSample.colorName = String(parsedData[6])
            currentSample.wavelengthValue = String(parsedData[7])
            currentSample.intensity = Double(parsedData[8]) ?? 0
            if(selected == 0) {
                currentSample.absorbanceValue = 0
            } else {
                currentSample.calculateAbsorbanceValue(controlIntensity: self.controlIntensity)
            }
            
            if(parsedData[9] == "NONE*") {
                currentSample.imageData = nil
            } else {
                let dataDecoded:NSData = NSData(base64Encoded: String(parsedData[9]), options: NSData.Base64DecodingOptions(rawValue: 0))!
                currentSample.imageData = UIImage(data: Data(referencing: dataDecoded))!
            }
            
        } catch let error as NSError {
            //If the sample doesn't exist on the disk already, return
            print("Failed to read file: sample\(selected)")
            print(error)
        }
        
        //Update the UI elements with either the default sample or what was loaded
        update()
    }

    //Drop down menu
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
        currentSample = SampleData()
        loadCurrent(selected: row)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.textBox {
            saveCurrent(selected: dropDown.selectedRow(inComponent: 0))
            self.dropDown.isHidden = false
            textField.endEditing(true)
        }
    }
    
    let imagePicker = UIImagePickerController()

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
    
    dismiss(animated: true, completion: nil)
    
    //Crop and process the picture just taken
    currentSample = dataReceived(image: cropImage(inputImage:pickedImage)!)
    
    //Update the UI
    update()
}
    
    /**
     *Crops an Image down to the 200x200 pixel centered square of the picture
     *@returns a cropped UIImage
     *@author Olivia Rorke
     */
    func cropImage(inputImage: UIImage) -> UIImage? {
        //Calculate center
        let sourceSize = inputImage.size
        let xCenter = sourceSize.width / 2
        let yCenter = sourceSize.height / 2
        
        //Create centered square
        let cropZone = CGRect(x:xCenter,
                              y:yCenter,
                              width:200,
                              height:200)
        
        //Crop down to the center 200x200 rectangle
        guard let cropped: CGImage = inputImage.cgImage?.cropping(to:cropZone)
        else {
            return nil
        }
        
        //Return the cropped image as a UIIMage
        let croppedImage: UIImage = UIImage(cgImage: cropped)
        return croppedImage
    }
    
    /**
     * Returns a sample data object using the image provided
     * @author Olivia Rorke
     */
    func dataReceived(image:UIImage) -> SampleData {
        //Create a new sample object
        let sample = SampleData()
        
        //Update the sample name
        sample.sampleName = sampleNameField.text ?? ""
        
        //Add the image to the sample
        sample.imageData = image
        
        //Count the red, blue, and green pixels and add to the sample
        let (red, green, blue) = calculateRGB(image: image)
        sample.redValue = red
        sample.greenValue = green
        sample.blueValue = blue
        
        //Debugging info
        print(red); print(green) ; print(blue)
        
        //Set the intensity and calculate wavelength info
        sample.setIntensity(intensity: (Double)(red + green + blue))
        sample.calculateColorName()
        sample.calculateWavelengthValue()
        if(dropDown.selectedRow(inComponent: 0) == 0) {
            sample.absorbanceValue = 0
        } else {
            sample.calculateAbsorbanceValue(controlIntensity: self.controlIntensity)
        }
        
        //Return the sample
        return sample
    }

    /*
    //called after a picture is taken, before session is stopped
    //labels defined here are refreshed with new data and displayed
    override func viewWillAppear(_ animated: Bool) {
        redLabel.text = "Red: \(sample.getRedValue())";
        greenLabel.text = "Green: \(sample.getGreenValue())";
        blueLabel.text = "Blue: \(sample.getBlueValue())";
        absorbanceLabel.text = String(format: "Absorbance: %.2f", sample.getAbsorbanceValue())
        colorLabel.text = "Color name: \(sample.getColorName())";
        wavelengthLabel.text = "Wavelength range: \(sample.getWavelengthValue())";
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
     */
    

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
