//
//  ViewController.swift
//  visionarycensor
//
//  Created by Vikentor Pierre on 7/21/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit
import AVFoundation // using this to work with AVFoundationCapture
import SnapKit

class MainViewController: UIViewController {
    
    // 1. declare a gloable captureSession object
    var myCaptureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var fontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var newCameraInput: AVCaptureDeviceInput? // toggle
    var newDevicePosition: AVCaptureDevice? // toggle
    
    var photoOutput: AVCapturePhotoOutput?
    
    // the preview before taking a photo
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    // this variable stored the final picture after you click the takePhoto button
    var theFinalPictureFromCamera: UIImage?
    
//
//    var toggleCameraPosition: UITapGestureRecognizer = {
//        let obj = UITapGestureRecognizer(target: self, action: #selector(toggleCamera))
//        obj.numberOfTapsRequired = 2
//        obj.numberOfTouchesRequired = 2
//
//        return obj
//    }()
    

    
    let takeButton:UIButton = {
        let obj = UIButton()
        obj.backgroundColor = .white
        obj.layer.cornerRadius = 30
        obj.clipsToBounds = true
        obj.addTarget(self, action: #selector(showPreview), for: .touchUpInside)
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupCaptureDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
        let toggle: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleCamera))
        toggle.numberOfTapsRequired = 2
        
        view.addGestureRecognizer(toggle)

    }
    override func loadView() {
        super.loadView()
        setupLayout()
    }
    func setupLayout(){
        view.backgroundColor = .black
        view.addSubview(takeButton)
        takeButton.snp.makeConstraints { (make) in
            make.centerXWithinMargins.equalToSuperview()
            make.size.equalTo(60)
            make.bottom.equalTo(-20)
        }
        
    }
    
    //2. second goto:setupCaptureSession method and config the session
    // settting the goodness of the resolution of the photo
    
    fileprivate func setupCaptureSession(){
        self.myCaptureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    // 3. config the device set the type of media
    // set the back and font and current camera and set the default camera position
    
    fileprivate func setupCaptureDevice(){
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: .video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices{
            if device.position == AVCaptureDevice.Position.back{
                self.backCamera = device
            }else if device.position == AVCaptureDevice.Position.front{
                self.fontCamera = device
            }
        }
        self.currentCamera = self.backCamera
    }
    
    // 4.
    fileprivate func setupInputOutput(){
        do{
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            photoOutput = AVCapturePhotoOutput()
            
            myCaptureSession.addInput(captureDeviceInput)
            
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])], completionHandler: nil)
            myCaptureSession.addOutput(photoOutput!)
        }catch{
            print(error)
        }
    }
    
    // 5. config the cameraPreview and setting the layer frame than inserting that layer into our view sublayer
    fileprivate func setupPreviewLayer(){
        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: self.myCaptureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    // final: 
    fileprivate func  startRunningCaptureSession(){
        self.myCaptureSession.startRunning()
    }
    
    @objc func showPreview(){
        let setting = AVCapturePhotoSettings()
        self.photoOutput?.capturePhoto(with: setting, delegate: self)
    }
    
    @objc func toggleCamera(){
        //print(" gester works ")
        self.myCaptureSession.beginConfiguration()

        newDevicePosition = (self.currentCamera?.position == AVCaptureDevice.Position.back) ? self.fontCamera: self.backCamera
        for input in myCaptureSession.inputs {
            myCaptureSession.removeInput(input as! AVCaptureDeviceInput)
        }
        do{
            newCameraInput = try AVCaptureDeviceInput(device: newDevicePosition!)
        }catch let err{ print(err)}

        if myCaptureSession.canAddInput(newCameraInput!){ myCaptureSession.addInput(newCameraInput!)}

        currentCamera = newDevicePosition
        myCaptureSession.commitConfiguration()
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// Camera photo Delegate
extension MainViewController: AVCapturePhotoCaptureDelegate{
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(){
            
            theFinalPictureFromCamera = UIImage(data: imageData)

//            let vc = Preview(nibName: "Preview", bundle: nil)
//
//            vc.contentView.image = theFinalPictureFromCamera
//            self.present(vc, animated: true, completion: nil)
            
            
            let vc = PreviewViewController()
            self.theFinalPictureFromCamera = UIImage(data: imageData)

            vc.content.image = theFinalPictureFromCamera
            self.present(vc, animated: true)
            
        }
    }
}

