//
//  ViewController.swift
//  visionarycensor
//
//  Created by Vikentor Pierre on 7/21/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit
import MobileCoreServices
import SnapKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    
    
    let takeButton:UIButton = {
        let obj = UIButton()
        obj.backgroundColor = .white
//        obj.setTitle("Button", for: .normal)
//        obj.setTitleColor(.blue, for: .normal)
        obj.layer.cornerRadius = 30
        obj.clipsToBounds = true
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
//        VicksetupNavigationBar()
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

    func VicksetupNavigationBar(){


        navigationItem.title = "Camera"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(lanuchCamera))
     
    }
    @objc func lanuchCamera(){
        let vc = CameraHelper()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

