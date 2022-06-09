//
//  GDImagePickerCell.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

@objc public protocol GDImagePickerCellDelegate: NSObjectProtocol {
    @objc optional func deleButtonClick(btn: Any)
}

class GDImagePickerCell: UICollectionViewCell {

    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var deleBtn: UIButton!
    @IBOutlet weak var playVideoImage: UIImageView!
    
    open weak var delegate: GDImagePickerCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 7
        self.layer.masksToBounds = true
    }

    @IBAction func deleBtnClick(_ sender: Any) {
        self.delegate?.deleButtonClick?(btn: sender)
    }
}
