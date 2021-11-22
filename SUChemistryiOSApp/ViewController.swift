//
//  ViewController.swift
//  AVFCamera
//


import AVFoundation
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
   /* INSERT MAIN UI VIEW CONTROLLER CODE*/

    @IBAction func toCamera(_ sender: Any) {
        performSegue(withIdentifier: "segueToCamera", sender: self)
    }
}

