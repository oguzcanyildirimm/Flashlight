//
//  ViewController.swift
//  Flashlight
//
//  Created by Oğuzcan Yıldırım on 11.12.2023.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {
    
    @IBOutlet weak var flashlightOnImage: UIImageView!
    @IBOutlet weak var flashlightOffImage: UIImageView!
    @IBOutlet var colorChangingView: UIView!
    
    var captureDevice: AVCaptureDevice?
    var isFlashlightOn = false
    var isBlack = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorChangingView.backgroundColor = .black
        
        // Connect the gesture recognizer with the defined function
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        colorChangingView.addGestureRecognizer(tapGesture)
        flashlightOnImage.isUserInteractionEnabled = true
        flashlightOnImage.addGestureRecognizer(tapGesture)

        // Check the flash capability of the device
        captureDevice = AVCaptureDevice.default(for: .video)
        do {
            try captureDevice?.lockForConfiguration()
            captureDevice?.torchMode = .off
            captureDevice?.unlockForConfiguration()
        } catch {
            print("An error occurred while setting the flash mode.")
        }
    }
    
    func changeBackgroundColor(to color: UIColor) {
        self.colorChangingView.backgroundColor = color
        }
    
    func toggleFlashlight() {
        isFlashlightOn = !isFlashlightOn

        do {
            try captureDevice?.lockForConfiguration()

            if isFlashlightOn {
                captureDevice?.torchMode = .on
            } else {
                captureDevice?.torchMode = .off
            }
            captureDevice?.unlockForConfiguration()
        } catch {
            print("The error occurred while changing the flash mode.")
        }
    }
    
    @objc func handleTap() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        toggleFlashlight()
        
        generator.prepare()
        generator.impactOccurred()
        
        if isBlack {
            changeBackgroundColor(to: .white)
        } else {
            changeBackgroundColor(to: .black)
        }
        isBlack = !isBlack
        }
    
    }
        
    

