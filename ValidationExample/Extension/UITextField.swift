//
//  UITextField.swift
//  ValidationExample
//
//  Created by Sung9 on 2018. 5. 29..
//  Copyright © 2018년 Sung9. All rights reserved.
//

import UIKit
import GestureRecognizerClosures

extension UITextField {
    func setAccessoryView(title : String, fontColor : String, backgroundColor : String, _ closure: @escaping ()->()){
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 66))
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(hex:fontColor), for: .normal)
        button.backgroundColor = UIColor(hex:backgroundColor)
        button.onTap { (tap) in
            DispatchQueue.main.async {
                closure()
            }
        }
        self.inputAccessoryView = button
    }
}
