//
//  ValidationHelper.swift
//  ValidationExample
//
//  Created by BV on 2018. 5. 29..
//  Copyright © 2018년 Sung9. All rights reserved.
//

import Foundation

/**
 * 유효성 검사를 하기위한 클래스
 */
class ValidationHelper {
    
    /**
     * 핸드폰번호 유효성 검사
     */
    class func phoneNumberCheck(_ value : String) -> Bool{
        
        let regex = "^01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    /**
     * 이메일 유효성 검사
     */
    class func emailCheck(_ value : String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let birthTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let result =  birthTest.evaluate(with: value)
        return result
    }
}

