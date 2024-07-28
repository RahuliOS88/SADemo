//
//  Endpoints.swift
//  SADemo
//
//  Created by Rahul Gupta on 18/07/24.
//

import Foundation

enum ApiUrl {
    static let baseUrl = "http://localhost:5001" // or http://127.0.0.1:5001
}

enum Endpoints {
    static let register = "\(ApiUrl.baseUrl)/api/register"
    static let login = "\(ApiUrl.baseUrl)/api/login"
    static let inspectionsStart = "\(ApiUrl.baseUrl)/api/inspections/start"
    static let submitInspections = "\(ApiUrl.baseUrl)/api/inspections/submit"
    static let generateRandomInspections = "\(ApiUrl.baseUrl)/api/generate_random_inspections/10"
    static let randomInspection = "\(ApiUrl.baseUrl)/api/random_inspection"
    static let getInspections = "\(ApiUrl.baseUrl)/api/inspections/"
    static let deleteInspections = "\(ApiUrl.baseUrl)/api/inspections/"
}
