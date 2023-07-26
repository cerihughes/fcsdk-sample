//
//  NetworkManager.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import Foundation

private extension String {
    static let loginURL = "\(scheme)://\(server):\(port)/csdk-sample/SDK/login"

    static func logoutURL(sessionID: String) -> String {
        "\(scheme)://\(server):\(port)/csdk-sample/SDK/login/id/\(sessionID)"
    }
}

protocol NetworkManager {
    func login(request: LoginRequest) async -> LoginResponse?
    func logout(sessionID: String) async -> Bool
}

class DefaultNetworkManager: NSObject, NetworkManager {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

    func login(request: LoginRequest) async -> LoginResponse? {
        guard let body = try? encoder.encode(request), let url = URL(string: .loginURL) else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, _) = try await session.data(for: request, delegate: self)
            return try? decoder.decode(LoginResponse.self, from: data)
        } catch {
            return nil
        }
    }

    func logout(sessionID: String) async -> Bool {
        guard let url = URL(string: .logoutURL(sessionID: sessionID)) else { return false }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        do {
            _ = try await URLSession.shared.data(for: request)
            return true
        } catch {
            return false
        }
    }
}

extension DefaultNetworkManager: URLSessionTaskDelegate {
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge
    ) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        guard let trust = challenge.protectionSpace.serverTrust else {
            return (.useCredential, nil)
        }

        let credential = URLCredential(trust: trust)
        return (.useCredential, credential)
    }
}
