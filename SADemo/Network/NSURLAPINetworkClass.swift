//
//  NSURLAPINetworkClass.swift
//  SADemo
//
//  Created by Rahul Gupta on 19/07/24.
//

import Foundation
import UIKit
import CoreData

enum REQUESTMETHOD {
    static let POST = "POST"
    static let GET = "GET"
    static let DELETE = "DELETE"
}

enum ServerResponseCodeEnum{
    static let TWOHUNDRED = 200
    static let FOURHUNDRED = 400
    static let FOURHUNDREDONE = 401
}

class APIService: NSObject {

    static func fetchLoginDataFromAPI(parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: Endpoints.login) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = REQUESTMETHOD.POST

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let error = NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }

            guard let responseData = data else {
                let error = NSError(domain: "No data received", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            completion(.success(responseData))
        }.resume()
    }

    static func registerUserApi(parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: Endpoints.register) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = REQUESTMETHOD.POST

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let error = NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }

            guard let responseData = data else {
                let error = NSError(domain: "No data received", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            completion(.success(responseData))
        }.resume()
    }

    static func startInspectionApi(completion: @escaping (Result<InspectionResponse, Error>) -> Void) {
        guard let url = URL(string: Endpoints.inspectionsStart) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = REQUESTMETHOD.GET

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let error = NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }

            guard let responseData = data else {
                let error = NSError(domain: "No data received", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            do {
                let inspection = try JSONDecoder().decode(InspectionResponse.self, from: responseData)
                completion(.success(inspection))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    static func getRandomInspectionApi(completion: @escaping (Result<InspectionResponse, Error>) -> Void) {
        guard let url = URL(string: Endpoints.randomInspection) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = REQUESTMETHOD.GET

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let error = NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }

            guard let responseData = data else {
                let error = NSError(domain: "No data received", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            do {
                let inspection = try JSONDecoder().decode(InspectionResponse.self, from: responseData)
                completion(.success(inspection))
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }

    static func getInspectionApi(id: Int, completion: @escaping (Result<InspectionResponse, Error>) -> Void) {
        guard let url = URL(string: "\(Endpoints.getInspections)\(id)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = REQUESTMETHOD.GET

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let error = NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }

            guard let responseData = data else {
                let error = NSError(domain: "No data received", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            do {
                let inspection = try JSONDecoder().decode(InspectionResponse.self, from: responseData)
                completion(.success(inspection))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    static func generateRandomInspectionApi(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: Endpoints.generateRandomInspections) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = REQUESTMETHOD.GET

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let error = NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }

            guard let responseData = data else {
                let error = NSError(domain: "No data received", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            completion(.success(responseData))

        }.resume()
    }

    static func deleteInspectionApi(id: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(Endpoints.deleteInspections)\(id)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = REQUESTMETHOD.DELETE

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let error = NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }

            completion(.success(Data()))
        }.resume()
    }

    static func submitInspectionApi(inspection: InspectionResponse, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: Endpoints.submitInspections) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = REQUESTMETHOD.POST

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let entityData = try JSONEncoder().encode(inspection)
            request.httpBody = entityData
        }
        catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let error = NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }

            guard let responseData = data else {
                let error = NSError(domain: "No data received", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            completion(.success(responseData))
        }.resume()
    }
}
