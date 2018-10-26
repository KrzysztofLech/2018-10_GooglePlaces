//
//  PlaceTableViewCell.swift
//  MoveApp
//
//  Created by Krzysztof Lech on 26/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var photoReference: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    private func resetCell() {
        thumbnailImageView.image = nil
        titleLabel.text = nil
        activityIndicator.startAnimating()
    }
    
    func update(name: String, photoReference: String) {
        titleLabel.text = name
        self.photoReference = photoReference
    }
}
