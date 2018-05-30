//
//  ViewController.swift
//  ValidationExample
//
//  Created by Sung9 on 2018. 5. 29..
//  Copyright © 2018년 Sung9. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    // MARK: Rx
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension BaseViewController{
    /**
     * 설정 및 백버튼 이름 지우기.
     * @param title
     * Usage self.setViewControllerTitle("")
     */
    
    func setViewControllerTitle(title : String){
        DispatchQueue.main.async {
            self.title = title
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    /*
     * 스토리보드 이름과 뷰컨트롤러 이름으로 해당 뷰컨트롤러를 리턴받는 함수.
     * @param sbName,vcName
     * @Usage self.returnVC(sbName:sName,vcName:vName)
     * @returns UIViewController
     */
    func returnVC(sbName : String, vcName : String) -> UIViewController{
        let storyboard = UIStoryboard(name: sbName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: vcName)
    }
    
    /**
     * Viewcontroller를 받아 네비게이션바로 푸시하기
     * @param UIViewController
     * Usage self.push(vc)
     */
    func push(vc : UIViewController){
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /**
     * 키보드 내리는 함수
     * Usage self.endEditing()
     */
    @objc func endEditing(){
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }
}
