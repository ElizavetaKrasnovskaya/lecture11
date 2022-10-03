//
//  GreetingViewController.swift
//  lecture11
//
//  Created by admin on 01/10/2022.
//

import UIKit

class GreetingViewController: UIViewController {

    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        Utilities.styleFilledButton(btnSignUp)
        Utilities.styleHollowButton(btnLogin)
    }
}
