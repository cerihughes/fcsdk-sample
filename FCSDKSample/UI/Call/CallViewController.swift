//
//  CallViewController.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import UIKit

class CallViewController: UIViewController {
    private let viewModel: CallViewModel

    private let callView = CallView()

    init(viewModel: CallViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = callView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        callView.state = .uninitialised
        callView.initialiseButton.addTarget(self, action: #selector(initialiseButtonTapped), for: .touchUpInside)
        callView.callButton.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
    }

    @objc private func initialiseButtonTapped(_ button: UIButton) {
        callView.state = .initialising
        Task {
            guard await viewModel.initialise() else {
                callView.state = .uninitialised
                return
            }

            callView.state = .initialised
            viewModel.localVideoView = callView.localVideoView
            viewModel.remoteVideoView = callView.remoteVideoView
        }
    }

    @objc private func callButtonTapped(_ button: UIButton) {
        callView.state = .calling
        Task {
            guard await viewModel.makeCall() else {
                callView.state = .initialised
                return
            }
            callView.state = .callInProgress
        }
    }
}
