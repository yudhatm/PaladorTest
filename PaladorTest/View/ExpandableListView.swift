//
//  ExpandableListView.swift
//  PaladorTest
//
//  Created by Yudha on 16/09/22.
//

import UIKit

class ExpandableListView: UIView {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var containerButton: UIButton!
    
    @IBOutlet weak var nameLabelLeftConstraint: NSLayoutConstraint!
    
    var haveChildView = false {
        didSet {
            initView()
        }
    }
    
    func initView() {
        arrowImage.isHidden = !haveChildView
        
        if haveChildView {
            containerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            self.toggleNestedHidden()
        }
    }
    
    func adjustNestedConstraint(nestedLevel: CGFloat = 1) {
        nameLabelLeftConstraint.constant = 16.0 * nestedLevel
    }
    
    @objc func buttonTapped() {
        toggleNestedHidden()
    }
    
    func toggleNestedHidden() {
        for subView in stackView.arrangedSubviews {
            subView.isHidden = !subView.isHidden
        }
    }
}
