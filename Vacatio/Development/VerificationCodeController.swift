//
//  VerificationCodeController.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import Foundation

class VerificationCodeController {
    static let shared = VerificationCodeController()

    private var components: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = Environment.firebaseEmulatorURL
        components.port = Int(Environment.firebaseEmulatorAuthPort)
        return components
    }
    
    private func getAuthVerificationCode(completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let baseURL = components.url
        else {
            preconditionFailure("Error: cannot create URL from components: \(components.debugDescription)")
        }
        
        // http:localhost:8090
        let targetURL = baseURL
            .appendingPathComponent("emulator/v1/projects")
            .appendingPathComponent(Environment.firebaseEmulatorAuthProjectID)
            .appendingPathComponent("verificationCodes")
        
        var urlRequest = URLRequest(url: targetURL)
        // This specifies that we will only accept JSON back.
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error { completion(.failure(.thrownError(error))) }
            
            guard let response = urlResponse as? HTTPURLResponse else { return }
            if let responseError = self.handleNetworkResponse(response: response) {
                completion(.failure(responseError))
            }
            
            guard let data: Data = data else { return completion(.failure(.noData)) }
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(TopLevelVerificationCodes.self, from: data)
                let verificationCodes: [VerificationCode] = result.verificationCodes
                guard let verificationCode = verificationCodes.last else {
                    return completion(.failure(.invalidURL(baseURL)))
                }
                completion(.success(verificationCode.code))
            } catch {
                completion(.failure(.couldNotDecode))
            }
        }.resume()
    }
    
    private func getRawJSON(urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let targetURL = URL(string: urlString) else {
            preconditionFailure("Error: cannot create URL: \(urlString)")
        }
        var urlRequest = URLRequest(url: targetURL)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error { completion(.failure(.thrownError(error))) }
            
            guard let response = urlResponse as? HTTPURLResponse else { return }
            if let responseError = self.handleNetworkResponse(response: response) {
                completion(.failure(responseError))
            }
            
            guard let data: Data = data else { return completion(.failure(.noData)) }
            do {
                let json = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                let convertedString = String(data: json, encoding: .utf8)
                completion(.success(convertedString ?? "{}"))
            } catch {
                completion(.failure(.couldNotDecode))
            }
        }.resume()
    }
    
    func getVerificationCodeFromAuthEmulator() -> String {
        var verificationCode = ""
        let group = DispatchGroup()
        group.enter()
        getAuthVerificationCode { result in
            switch result {
                case .success(let testVerficationCode):
                    verificationCode = testVerficationCode
                    group.leave()
                case .failure(let networkError):
                    print("Error: \(networkError)")
                    
                    guard let baseURL = self.components.url else { return }
                    let urlString = String(describing: baseURL)
                    self.getRawJSON(urlString: urlString) { result in
                        switch result {
                            case .success(let json):
                                print(json)
                            case .failure(let error):
                                fatalError("Error: \(error)")
                        }
                    }
            }
        }
        // Wait for the SMS verification code to be retrieved from the Firebase Auth Emulator endpoint.
        group.wait()
        return verificationCode
    }
    
    private func handleNetworkResponse(response: HTTPURLResponse) -> NetworkError? {
        switch response.statusCode {
            case 200...299:
                return nil
            case 300...399:
                return NetworkError.redirectionError
            case 400...499:
                return NetworkError.clientError
            case 500...599:
                return NetworkError.serverError
            case 600:
                return NetworkError.invalidRequest
            default:
                return NetworkError.unknownError
        }
    }
}
