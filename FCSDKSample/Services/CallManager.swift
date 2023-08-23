//
//  CallManager.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import FCSDKiOS
import UIKit

protocol CallManagerDelegate: AnyObject {
    func callManagerDidEndCall(_ callManager: CallManager)
}

protocol CallManager {
    var delegate: CallManagerDelegate? { get nonmutating set }

    var localVideoView: UIView? { get nonmutating set }
    var remoteVideoView: UIView? { get nonmutating set }

    func initialise() async -> Bool
    func makeCall() async -> Bool
    func endCall() -> Bool
}

class DefaultCallManager: NSObject, CallManager {
    private let networkManager: NetworkManager

    private var uc: ACBUC?
    private var currentCall: ACBClientCall?

    weak var delegate: CallManagerDelegate?

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    @MainActor
    var localVideoView: UIView? {
        get {
            uc?.phone.previewView
        }
        set {
            uc?.phone.previewView = newValue
        }
    }

    @MainActor
    var remoteVideoView: UIView? {
        get {
            uc?.phone.remoteView
        }
        set {
            uc?.phone.remoteView = newValue
        }
    }

    func initialise() async -> Bool {
        await ACBClientPhone.requestMicrophoneAndCameraPermission(true, video: true)

        let request = LoginRequest(username: .username, password: .password)
        guard let response = await networkManager.login(request: request) else { return false }

        let uc = await ACBUC.uc(withConfiguration: response.sessionid, delegate: nil)
        await uc.setNetworkReachable(true)
        uc.acceptAnyCertificate(false)
        uc.useCookies = false
        await uc.startSession()

        self.uc = uc
        return true
    }

    func makeCall() async -> Bool {
        guard let currentCall = await uc?.phone.createCall(
            toAddress: .callDestination,
            withAudio: .sendAndReceive,
            video: .sendAndReceive,
            delegate: nil
        ) else {
            return false
        }

        self.currentCall = currentCall
        return true
    }

    func endCall() -> Bool {
        guard let currentCall else { return false }
        currentCall.end()
        return true
    }
}

extension DefaultCallManager: ACBClientCallDelegate {
    func call(_ call: ACBClientCall, didChange status: ACBClientCallStatus) {
        if status >= .inCall {
            delegate?.callManagerDidEndCall(self)
        }
    }
}
