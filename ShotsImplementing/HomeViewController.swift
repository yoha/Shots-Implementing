//
//  HomeViewController.swift
//  ShotsImplementing
//
//  Created by Yohannes Wijaya on 2/29/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var userProfileButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundMaskView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var userPopoverView: UIView!
    @IBOutlet weak var shareSheetView: UIView!
    
    @IBOutlet weak var dialogHeaderView: UIView!
    @IBOutlet weak var dialogImageButton: UIButton!
    @IBOutlet weak var dialogHeaderTitleLabel: UILabel!
    @IBOutlet weak var dialogHeaderAuthorLabel: UILabel!
    @IBOutlet weak var dialogAvatarImageView: UIImageView!
    @IBOutlet weak var dialogFavoritesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    // MARK: - IBAction Methods
    
    @IBAction func userProfileButtonDidTouch(sender: UIButton) {
        self.userPopoverView.hidden = false
    }
    
    @IBAction func dialogImageButtonDidTouch(sender: UIButton) {
    }
    
    @IBAction func likeButtonDidTouch(sender: UIButton) {
    }
    
    @IBAction func shareButtonDidTouch(sender: UIButton) {
        self.shareSheetView.hidden = false
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        insertBlurView(self.backgroundMaskView, style: UIBlurEffectStyle.Dark)
        insertBlurView(self.dialogHeaderView, style: .Dark)
    }

}
