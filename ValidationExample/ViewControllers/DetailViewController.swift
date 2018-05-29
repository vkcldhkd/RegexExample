//
//  DetailViewController.swift
//  ValidationExample
//
//  Created by BV on 2018. 5. 29..
//  Copyright © 2018년 Sung9. All rights reserved.
//

import UIKit
import RxSwift

enum RegexType : String{
    case email
    case phone
}

class DetailViewController: BaseViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var type : RegexType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.inputTextField.keyboardType = self.type == RegexType.email ? UIKeyboardType.emailAddress : UIKeyboardType.numberPad
        
        // inputTextField text  체크
        self.inputTextField.rx.text
            .orEmpty // 옵셔널이 아니도록 만듭니다.
            .debounce(0.3, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribe(onNext: { (inputText) in
                if inputText.count == 0 {
                    self.errorLabel.isHidden = true
                }else{
                    self.errorLabel.isHidden = self.textCheck(inputText: inputText, type: self.type) == true ? true : false
                }
                
            })
            .disposed(by: self.disposeBag)
        
        //inputTextField 에 악세사리 뷰 설정
        self.inputTextField.setAccessoryView(title: "메인으로", fontColor: Constants_fonts.GET_FONT_COLOR_MAIN_BUTTON_WHITE(), backgroundColor: Constants_fonts.GET_FONT_COLOR_MAIN_BUTTON_BLACK()) {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setViewControllerTitle(title: self.type!.rawValue)
    }
}

extension DetailViewController {
    func textCheck(inputText : String, type : RegexType) -> Bool {
        switch type {
        case .email:
            return inputText.count > 0 && ValidationHelper.emailCheck(inputText) ? true : false
        case .phone :
            return inputText.count > 0 && ValidationHelper.phoneNumberCheck(inputText) ? true : false
        }
    }
}
