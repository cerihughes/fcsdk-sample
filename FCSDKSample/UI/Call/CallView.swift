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
        case uninitialised, initialising, initialised, calling, callInProgress, ending
    }

    let localVideoView = UIView()
    let remoteVideoView = UIView()
    let initialiseButton = UIButton.create(title: "Initialise")
    let callButton = UIButton.create(title: "Make Call")
    let endButton = UIButton.create(title: "End Call")

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

        addSubviews(remoteVideoView, localVideoView, initialiseButton, callButton, endButton)

        remoteVideoView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        localVideoView.snp.makeConstraints { make in
            make.size.equalTo(remoteVideoView).dividedBy(4)
            make.trailing.bottom.equalTo(remoteVideoView).inset(24)
        }

        initialiseButton.snp.makeConstraints { make in
            make.trailing.equalTo(localVideoView)
            make.top.equalTo(remoteVideoView).inset(24)
        }

        callButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(initialiseButton)
        }

        endButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(callButton)
        }
    }

    var state: State = .uninitialised {
        didSet {
            initialiseButton.isHidden = state.isNotIn(.uninitialised, .initialising)
            initialiseButton.isEnabled = state != .initialising
            callButton.isHidden = state.isNotIn(.initialised, .calling)
            callButton.isEnabled = state != .calling
            endButton.isHidden = state.isNotIn(.callInProgress, .ending)
            endButton.isEnabled = state != .ending
        }
    }
}

private extension UIButton {
    static func createCallButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitle("Make Call", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }
}

private extension CallView.State {
    func isIn(_ states: CallView.State...) -> Bool {
        states.contains(self)
    }

    func isNotIn(_ states: CallView.State...) -> Bool {
        !states.contains(self)
    }
}
