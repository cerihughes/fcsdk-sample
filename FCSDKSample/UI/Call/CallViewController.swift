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
}
