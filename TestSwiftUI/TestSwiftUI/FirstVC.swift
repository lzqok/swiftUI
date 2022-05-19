//
//  FirstVC.swift
//  TestSwiftUI
//
//  Created by 柳宗青 on 2022/5/11.
//

import UIKit
import SwiftUI

class FirstVC: UIViewController {

    var text = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        let infoLabel = UILabel()
        infoLabel.text = text
        self.view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let btn = UIButton()
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitle("To SwiftUI", for: .normal)
        btn.addTarget(self, action: #selector(toSwiftUI), for: .touchUpInside)
        self.view.addSubview(btn)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.topAnchor.constraint(equalTo: infoLabel.bottomAnchor).isActive = true
        btn.centerXAnchor.constraint(equalTo: infoLabel.centerXAnchor).isActive = true
        
        let names = ["names","lily","perig"]
        for i in 0..<10 {
            names[i]
        }
        
    }
    
    @objc func toSwiftUI() {
        let vc = UIHostingController(rootView: ContentView())
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    deinit {
        print("deinit",self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
