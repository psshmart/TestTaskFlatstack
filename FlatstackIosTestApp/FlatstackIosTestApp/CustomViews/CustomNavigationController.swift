//
//  CustomNavigationController.swift
//  FlatstackIosTestApp
//
//  Created by Svetlana Safonova on 13.06.2021.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
}
