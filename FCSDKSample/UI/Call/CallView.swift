//
//  CallView.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import SnapKit
import UIKit

class CallView: UIView {
    let localVideoView = UIView()
    let remoteVideoView = UIView()
    let callButton = UIButton.createCallButton()
    
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

        addSubviews(remoteVideoView, localVideoView, callButton)

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
