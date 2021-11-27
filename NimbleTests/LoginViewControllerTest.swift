//
//  LoginViewControllerTest.swift
//  NimbleTests
//
//  Created by Abdul Rahim on 27/11/21.
//

import Foundation
import XCTest

class LoginViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_render_logo_image() {
        let sut = LoginViewController(image: UIImage(named: "nimble-logo"))
        _ = sut.view
        XCTAssertEqual(sut.image, UIImage(named: "nimble-logo"))
    }
    
}
