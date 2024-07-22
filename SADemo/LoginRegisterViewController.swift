//
//  LoginViewController.swift
//  SADemo
//
//  Created by Rahul Gupta on 19/07/24.
//

import UIKit

enum ViewType: String {
    case login = "login"
    case register = "register"
}

class LoginRegisterViewController: MasterViewController {
    var viewType: ViewType = .login
    private var viewModel = LoginRegisterViewModel()
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        if viewType == .login {
            actionButton.setTitle("Login", for: .normal)
        } else {
            actionButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func RegisterOrLoginAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if validateCredentials() {
            viewModel.authenticationData.email = usernameTextfield.text ?? ""
            viewModel.authenticationData.password = passwordTextfield.text ?? ""

            if viewType == .register {
                viewModel.callRegisterApi()
            } else {
                viewModel.callLoginApi()
            }
        }
    }
    
    func validateCredentials() -> Bool {
        if usernameTextfield.text == nil || usernameTextfield.text == "" {
            return false
        } else if passwordTextfield.text == nil || passwordTextfield.text == "" {
            return false
        } else {
            return true
        }
    }

    func updateUI() {
        viewModel.onSuccess = {
            // Handle success, update UI or perform segue
            print("API call succeeded")
            if self.viewType == .login {
                self.moveToDashboardScreen()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    self.showAlert(tittle: "Success!!", messsage: "User registred successfully!!")
                    self.passwordTextfield.text = ""
                    self.usernameTextfield.text = ""
                    self.viewType = .login
                    self.actionButton.setTitle("Login", for: .normal)
                })

            }
        }

        viewModel.onFailure = { error in
            // Handle failure, show alert or error message
            self.showAlert(tittle: "Error", messsage: "Invalid user or password")
            print("API call failed with error: \(error.localizedDescription)")
        }


    }

    func moveToDashboardScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardVc = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.navigationController?.pushViewController(dashboardVc, animated: true)
    }
}
