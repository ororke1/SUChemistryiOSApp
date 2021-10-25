//
//  ViewController.swift
//  AVFCamera
//


import AVFoundation
import UIKit

class ViewController: UIViewController {
    
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

// waiting for others to push code to start working on showing data on UI
    // Deletes the current samples saved data or just clears the screen back to default if no data is saved
    @objc
    func deleteAction(){
        
    }
    // Saves the current samples data(name,concentration, RGB, absorbance, wavelength, thumbnails)
    @objc
    func saveAction(){
        
    }
    
    func defaultValues(){
        
    }
    
    func updateValues(){
        
    }
    
    func deleteValues(){

    }
}

extension ViewController: AVCapturePhotoCaptureDelegate {
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

