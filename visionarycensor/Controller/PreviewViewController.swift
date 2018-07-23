//
//  ViewController.swift
//  visionarycensor
//
//  Created by Vikentor Pierre on 7/22/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation // using this to work with AVFoundationCapture

class PreviewViewController: UIViewController {
    
//
    let cancelButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("Cancel", for: .normal)

        obj.setTitleColor( .red, for: .normal)
   
        obj.addTarget(self, action: #selector(cancelbutton), for: .touchUpInside)
        return obj
    }()
    
    let content:UIImageView = {
        let obj = UIImageView()
        obj.backgroundColor = .blue
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadView() {
        super.loadView()
        setupLayout()

    }
    func setupLayout(){
        self.view.addSubview(content)
        view.addSubview(cancelButton)
        
        //content.addSubview(cancelButton)
        content.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        cancelButton.snp.makeConstraints { (make) in
            make.leading.top.equalTo(50)
        }
    }
    
    
    @objc func cancelbutton(){
        self.dismiss(animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
