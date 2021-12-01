
//
//  ViewController.swift
//  AVFCamera
//


import AVFoundation
import UIKit

class ViewController2: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!

    let imagePicker = UIImagePickerController()
    
    static var sample = SampleData()
    let control = SampleData()
    
    //labels for data from camera
    var labelRed = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 50))
    var labelGreen = UILabel(frame: CGRect(x: 0, y: 20, width: 1000, height: 50))
    var labelBlue = UILabel(frame: CGRect(x: 0, y: 40, width: 1000, height: 50))
    var labelIntensity = UILabel(frame: CGRect(x: 0, y: 60, width: 1000, height: 50))
    var labelAbsorbance = UILabel(frame: CGRect(x: 0, y: 80, width: 1000, height: 50))
    var labelColorName = UILabel(frame: CGRect(x: 0, y: 100, width: 1000, height: 50))
    var labelWavelengthValue = UILabel(frame: CGRect(x: 0, y: 120, width: 1000, height: 50))

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
    
    //called after a picture is taken, before session is stopped
    //labels defined here are refreshed with new data and displayed
    override func viewWillAppear(_ animated: Bool) {
        labelRed.text = "Red: \(ViewController2.sample.getRedValue())";
        labelGreen.text = "Green: \(ViewController2.sample.getGreenValue())";
        labelBlue.text = "Blue: \(ViewController2.sample.getBlueValue())";
        labelIntensity.text = String(format: "Intensity: %.0f", ViewController2.sample.getIntensity())
        labelAbsorbance.text = String(format: "Absorbance: %.2f", ViewController2.sample.getAbsorbanceValue())
        labelColorName.text = "Color name: \(ViewController2.sample.getColorName())";
        labelWavelengthValue.text = "Wavelength range: \(ViewController2.sample.getWavelengthValue())";
        view.addSubview(labelRed)
        view.addSubview(labelGreen)
        view.addSubview(labelBlue)
        view.addSubview(labelIntensity)
        view.addSubview(labelAbsorbance)
        view.addSubview(labelColorName)
        view.addSubview(labelWavelengthValue)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        
        imageView.image = pickedImage
        let sample = fillSampleDataObject(image:pickedImage)
        sample.calculateAbsorbanceValue(control: control)
        
        dismiss(animated: true, completion: nil)
    }

    //populates sample with data from the camera
    //call after taking a photo of either a sample or control
    func fillSampleDataObject(image:UIImage) -> SampleData {
        let (red, green, blue) = calculateRGB(image:image)
        ViewController2.sample.setRedValue(redValue:red)
        ViewController2.sample.setGreenValue(greenValue:green)
        ViewController2.sample.setBlueValue(blueValue:blue)
        
        let intensity = (Double)(red + green + blue)
        ViewController2.sample.setIntensity(intensity:intensity)
        
        ViewController2.sample.calculateColorName()
        ViewController2.sample.calculateWavelengthValue()

        return ViewController2.sample
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
 /*
    //capture session
    var session: AVCaptureSession?
    //photo output
    let output = AVCapturePhotoOutput()
    //video preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    //shutter button
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 50
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        previewLayer.backgroundColor = UIColor.systemRed.cgColor
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        checkCameraPermissions()
        
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        
        shutterButton.center = CGPoint(x: view.frame.size.width/2
                                       , y: view.frame.size.height - 200)
    }
    
    private func checkCameraPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
        //request
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else{
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted:
         break
        case .denied:
        break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    private func setUpCamera(){
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                if session.canAddOutput(output){
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                session.startRunning()
                self.session = session
                
            }
            catch{
                print(error)
            }
        }
    }
    
    @objc private func didTapTakePhoto(){
        output.capturePhoto(with: AVCapturePhotoSettings(),
                            delegate: self)
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

extension ViewController2: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else{
            return
        }
        
        let image = UIImage(data: data)
        
        let (red, green, blue) = calculateRGB(image: image!)
        print(red)
        print(green)
        print(blue)
        
        session?.stopRunning()
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
}

*/
