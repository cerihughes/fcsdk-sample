//
//  CallManager.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import FCSDKiOS
import UIKit

protocol CallManager {
    var localVideoView: UIView? { get nonmutating set }
    var remoteVideoView: UIView? { get nonmutating set }

    func initialise() async -> Bool
    func makeCall() async -> Bool
}

class DefaultCallManager: NSObject, CallManager {
    private let networkManager: NetworkManager

    private var uc: ACBUC?
    private var currentCall: ACBClientCall?

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    @MainActor
    var localVideoView: UIView? {
        get {
            uc?.phone.remoteView
        }
        set {
            uc?.phone.remoteView = newValue
        }
    }

    var remoteVideoView: UIView?

    func initialise() async -> Bool {
        let request = LoginRequest(username: .username, password: .password)
        guard let response = await networkManager.login(request: request) else { return false }

        let uc = await ACBUC.uc(withConfiguration: response.sessionid, delegate: self)
        await uc.startSession()

        self.uc = uc
        return true
    }

    func makeCall() async -> Bool {
        guard let currentCall = await uc?.phone.createCall(
            toAddress: .callDestination,
            withAudio: .sendAndReceive,
            video: .sendAndReceive,
            delegate: self
        ) else {
            return false
        }

        Task { @MainActor in
            currentCall.remoteView = remoteVideoView
        }

        self.currentCall = currentCall
        return true
    }
}

extension DefaultCallManager: ACBUCDelegate {

}

extension DefaultCallManager: ACBClientPhoneDelegate {

}

extension DefaultCallManager: ACBClientCallDelegate {

}
