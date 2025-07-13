//
//  APISession.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/13/25.
//

import Foundation
import SwiftKeychainWrapper

final class APISession {
    static let shared = APISession()
    private init() {}
    
    func appleSignIn(userId: String, email: String?, userName: String?, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/auth/apple-signin") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any?] = [
            "userId": userId,
            "email": email,
            "userName": userName
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(LoginResponse.self, from: data)
                    if res.success {
                        completion(.success(res))
                    } else {
                        let errorMsg = res.error ?? "Apple 로그인 실패"
                        completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: errorMsg])))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func updateNickname(userId: String, nickname: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/user/nickname") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any?] = [
            "userId": userId,
            "nickname": nickname
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(LoginResponse.self, from: data)
                    if res.success, let user = res.user {
                        completion(.success(user))
                    } else {
                        let errorMsg = res.error ?? "닉네임 업데이트 실패"
                        completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: errorMsg])))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchInfo(completion: @escaping (Result<User, Error>) -> Void) {
        guard let jwtToken = KeychainWrapper.standard.string(forKey: "jwtToken"),
              let url = URL(string: "http://localhost:3000/api/user/me") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
