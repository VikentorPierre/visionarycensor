//
//  ViewController.swift
//  visionarycensor
//
//  Created by Vikentor Pierre on 7/22/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit
import SnapKit

class PreviewViewController: UIViewController {
    
    let content:UIImageView = {
        let obj = UIImageView()
        return obj
    }()
    let subContentView:UIView = {
        let obj = UIView()
        obj.backgroundColor = UIColor(named: .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5))
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
        content.addSubview(subContent)
        content.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        subContent.snp.makeConstraints { (make) in
            make.leadingMargin.topMargin.trailingMargin.equalToSuperview()
            make.height.equalTo(60)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
