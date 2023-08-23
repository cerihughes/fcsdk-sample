//
//  FCSDK+Extensions.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import FCSDKiOS
import Foundation

extension ACBClientCallStatus {
    var displayString: String {
        switch self {
        case .setup:
            return "setup"
        case .preparingBufferViews:
            return "preparingBufferViews"
        case .alerting:
            return "alerting"
        case .ringing:
            return "ringing"
        case .mediaPending:
            return "mediaPending"
        case .inCall:
            return "inCall"
        case .timedOut:
            return "timedOut"
        case .busy:
            return "busy"
        case .notFound:
            return "notFound"
        case .error:
            return "error"
        case .ended:
            return "ended"
        }
    }
}
