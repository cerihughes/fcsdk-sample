//
//  CallView.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import SnapKit
import UIKit

class CallView: UIView {
    enum State {
        case uninitialised, initialising, initialised, calling, callInProgress
    }

    let localVideoView = UIView()
    let remoteVideoView = UIView()
    let initialiseButton = UIButton.create(title: "Initialise")
    let callButton = UIButton.create(title: "Make Call")

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white

        remoteVideoView.backgroundColor = .lightGray
        localVideoView.backgroundColor = .gray

        addSubviews(remoteVideoView, localVideoView, initialiseButton, callButton)

        remoteVideoView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        localVideoView.snp.makeConstraints { make in
            make.size.equalTo(remoteVideoView).dividedBy(4)
            make.trailing.bottom.equalTo(remoteVideoView).inset(24)
        }

        callButton.snp.makeConstraints { make in
            make.trailing.equalTo(localVideoView)
            make.top.equalTo(remoteVideoView).inset(24)
        }

        initialiseButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(callButton)
        }
    }

    var state: State = .uninitialised {
        didSet {
            callButton.isHidden = !state.isInitialised
            initialiseButton.isHidden = state.isInitialised
            callButton.isEnabled = !state.isInProgress
            initialiseButton.isEnabled = !state.isInProgress
        }
    }
}

private extension UIButton {
    static func create(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.darkGray, for: .disabled)
        return button
    }
}

private extension CallView.State {
    var isInitialised: Bool {
        switch self {
        case .uninitialised, .initialising:
            return false
        default:
            return true
        }
    }

    var isInProgress: Bool {
        switch self {
        case .initialising, .calling, .callInProgress:
            return true
        default:
            return false
        }
    }
}
