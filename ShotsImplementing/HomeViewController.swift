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
        UIView.animateWithDuration(0.7, animations: { [unowned self] () -> Void in
            self.dialogView.frame = CGRectMake(0, 0, 375, 667)
            self.dialogView.layer.cornerRadius = 0
            self.dialogImageButton.frame = CGRectMake(0, 0, 375, 280)
            self.shareButton.alpha = 0
            self.likeButton.alpha = 0
            self.userProfileButton.alpha = 0
            self.dialogHeaderView.alpha = 0
            }) { (_) -> Void in
                self.performSegueWithIdentifier("segueToDetailViewController", sender: self)
        }
    }
    
    @IBAction func likeButtonDidTouch(sender: UIButton) {
    }
    
    @IBAction func shareButtonDidTouch(sender: UIButton) {
        self.shareSheetView.hidden = false
        self.shareSheetView.alpha = 0.0
        UIView.animateWithDuration(0.5) { [unowned self] () -> Void in
            self.shareSheetView.alpha = 1.0
        }
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        insertBlurView(self.backgroundMaskView, style: UIBlurEffectStyle.Dark)
        insertBlurView(self.dialogHeaderView, style: .Dark)
        
        let transformScale = CGAffineTransformMakeScale(0.5, 0.5)
        let transformTranslate = CGAffineTransformMakeTranslation(0, -234)
        self.dialogView.transform = CGAffineTransformConcat(transformScale, transformTranslate)
        
        UIView.animateWithDuration(0.5) { [unowned self] () -> Void in
            let transformScale = CGAffineTransformMakeScale(1.0, 1.0)
            let transformTranslate = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(transformScale, transformTranslate)
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
