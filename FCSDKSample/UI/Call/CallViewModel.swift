//
//  CallViewModel.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import UIKit

class CallViewModel {
    private let callManager: CallManager

    init(callManager: CallManager) {
        self.callManager = callManager
    }

    var localVideoView: UIView? {
        get {
            callManager.localVideoView
        }
        set {
            callManager.localVideoView = newValue
        }
    }
    var remoteVideoView: UIView? {
        get {
            callManager.remoteVideoView
        }
        set {
            callManager.remoteVideoView = newValue
        }
    }

    func initialise() async -> Bool {
        await callManager.initialise()
    }

    func makeCall() async -> Bool {
        await callManager.makeCall()
    }
}
