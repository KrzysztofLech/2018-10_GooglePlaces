//
//  NoDataView.swift
//  MoveApp
//
//  Created by Krzysztof Lech on 26/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

enum NoDataViewState {
    case waitingForGPS
    case waitingForDownloading
    case hidden
}

class NoDataView: UIView {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var label: UILabel!
    
    var state: NoDataViewState = .waitingForGPS {
        didSet {
            switch state {
            case .waitingForGPS:
                activityIndicator.startAnimating()
                label.text = "Waiting for GPS"
                label.isHidden = false
                
            case .waitingForDownloading:
                activityIndicator.startAnimating()
                label.text = "Downloading data"
                label.isHidden = false
                
            case .hidden:
                activityIndicator.stopAnimating()
                label.isHidden = true
            }
        }
    }
}
