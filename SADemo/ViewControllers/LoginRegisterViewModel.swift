//
//  LoginRegisterViewModel.swift
//  SADemo
//
//  Created by Rahul Gupta on 20/07/24.
//

import Foundation

class LoginRegisterViewModel: NSObject {
    var onSuccess: (() -> Void)?
    var onFailure: ((Error) -> Void)?

    var authenticationData: Authentication = Authentication()
    
    override init() {
        super.init()
    }

    func callLoginApi() {

        let parameters: [String: Any] = [
            "email": authenticationData.email ?? "",
            "password": authenticationData.password ?? ""
        ]

        APIService.fetchLoginDataFromAPI(parameters: parameters) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.handleSuccess(data: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.handleError(error: error)
                }
            }
        }
    }

    func handleSuccess(data: Data) {
        DispatchQueue.main.async {
            self.onSuccess?()
        }
    }

    func handleError(error: Error) {
        DispatchQueue.main.async {
            self.onFailure?(error)
        }
    }

    func callRegisterApi() {

        let parameters: [String: Any] = [
            "email": authenticationData.email ?? "",
            "password": authenticationData.password ?? ""
        ]

        APIService.registerUserApi(parameters: parameters) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.handleSuccess(data: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.handleError(error: error)
                }
            }
        }
    }


}
