//
//  ViewController.swift
//  SADemo
//
//  Created by Rahul Gupta on 18/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func selectOption(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginRegisterViewController") as! LoginRegisterViewController
        if sender == loginButton {
            vc.viewType = .login
        } else {
            vc.viewType = .register
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class MasterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func showAlert(tittle: String, messsage: String) {
        let alertController = UIAlertController(title: tittle, message: messsage, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Handle OK button tap
        }

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}

