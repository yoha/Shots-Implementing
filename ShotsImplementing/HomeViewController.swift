//
//  HomeViewController.swift
//  ShotsImplementing
//
//  Created by Yohannes Wijaya on 2/29/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Stored Properties
    
    var dynamicAnimator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var gravityBehavior: UIGravityBehavior!
    var snapBehavior: UISnapBehavior!
    
    var data = getData()
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var userProfileButton: UIButton!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundMaskView: UIView!
   
    @IBOutlet weak var userPopoverView: UIView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var shareLabelsView: UIView!
    @IBOutlet weak var shareSheetView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    @IBOutlet weak var maskButton: UIButton!
    
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var dialogHeaderView: UIView!
    @IBOutlet weak var dialogImageButton: UIButton!
    @IBOutlet weak var dialogHeaderTitleLabel: UILabel!
    @IBOutlet weak var dialogHeaderAuthorLabel: UILabel!
    @IBOutlet weak var dialogAvatarImageView: UIImageView!
    @IBOutlet weak var dialogFavoritesLabel: UILabel!
    
    @IBOutlet weak var panGestureRecorgnizer: UIPanGestureRecognizer!
    
    // MARK: - IBAction Methods
    
    @IBAction func maskButtonDidTouch(sender: UIButton) {
        SpringAnimation.spring(0.5) { [unowned self] () -> Void in
            self.maskButton.alpha = 0
        }
        self.hideShareView()
        self.hideUserPopoverView()
    }
    
    @IBAction func userProfileButtonDidTouch(sender: UIButton) {
        self.userPopoverView.hidden = false
      
        let transformScale = CGAffineTransformMakeScale(0.3, 0.3)
        let transformTranslate = CGAffineTransformMakeTranslation(60, -60)
        self.userPopoverView.transform = CGAffineTransformConcat(transformScale, transformTranslate)
        
        self.userPopoverView.alpha = 0.0
        
        self.showMask()
        
        SpringAnimation.spring(0.5) { [unowned self] () -> Void in
            let transformScale = CGAffineTransformMakeScale(1.0, 1.0)
            let transformTranslate = CGAffineTransformMakeTranslation(0, 0)
            self.userPopoverView.transform = CGAffineTransformConcat(transformScale, transformTranslate)
            self.userPopoverView.alpha = 1.0
        }
    }
    
    @IBAction func dialogImageButtonDidTouch(sender: UIButton) {
        SpringAnimation.springWithCompletion(0.5, animations: { [unowned self] () -> Void in
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
        self.shareSheetView.alpha = 0
        self.shareSheetView.transform = CGAffineTransformMakeTranslation(0, 234)
        self.shareLabelsView.alpha = 0
        self.emailButton.transform = CGAffineTransformMakeTranslation(0, 234)
        self.twitterButton.transform = CGAffineTransformMakeTranslation(0, 234)
        self.facebookButton.transform = CGAffineTransformMakeTranslation(0, 234)
        self.showMask()
        SpringAnimation.spring(0.5) { [unowned self] () -> Void in
            self.shareSheetView.alpha = 1
            self.shareSheetView.transform = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        }
        SpringAnimation.springWithDelay(0.5, delay: 0.05) { [unowned self] () -> Void in
            self.emailButton.transform = CGAffineTransformMakeTranslation(0, 0)
        }
        SpringAnimation.springWithDelay(0.5, delay: 0.10) { [unowned self] () -> Void in
            self.twitterButton.transform = CGAffineTransformMakeTranslation(0, 0)
        }
        SpringAnimation.springWithDelay(0.5, delay: 0.15) { [unowned self] () -> Void in
            self.facebookButton.transform = CGAffineTransformMakeTranslation(0, 0)
        }
        SpringAnimation.springWithDelay(0.5, delay: 0.20) { [unowned self] () -> Void in
            self.shareLabelsView.alpha = 1
        }
    }
    
    @IBAction func handlePanGesture(sender: UIPanGestureRecognizer) {
        let locationOfPanGesture = sender.locationInView(self.view)
        let locationOfDialogView = sender.locationInView(self.dialogView)
        
        if sender.state == UIGestureRecognizerState.Began {
            self.dynamicAnimator.removeAllBehaviors()
            let centerOffset = UIOffsetMake(locationOfDialogView.x - CGRectGetMidX(self.dialogView.bounds), locationOfDialogView.y - CGRectGetMidY(self.dialogView.bounds))
            self.attachmentBehavior = UIAttachmentBehavior(item: self.dialogView, offsetFromCenter: centerOffset, attachedToAnchor: locationOfPanGesture)
            self.attachmentBehavior.frequency = 0
            self.dynamicAnimator.addBehavior(self.attachmentBehavior)
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            self.attachmentBehavior.anchorPoint = locationOfPanGesture
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            self.dynamicAnimator.removeBehavior(self.attachmentBehavior)
            self.snapBehavior = UISnapBehavior(item: self.dialogView, snapToPoint: self.view.center)
            self.dynamicAnimator.addBehavior(self.snapBehavior)
            
            let translationOfPanGestureInPoint = sender.translationInView(self.view)
            if translationOfPanGestureInPoint.y > 200 {
                self.dynamicAnimator.removeAllBehaviors()
                let gravityBehavior = UIGravityBehavior(items: [self.dialogView])
                gravityBehavior.gravityDirection = CGVectorMake(0, 10)
                self.dynamicAnimator.addBehavior(gravityBehavior)
            }
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
        
        SpringAnimation.spring(0.5) { [unowned self] () -> Void in
            let transformScale = CGAffineTransformMakeScale(1.0, 1.0)
            let transformTranslate = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(transformScale, transformTranslate)
        }
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - Helper Methods
    
    private func hideShareView() {
        SpringAnimation.spring(0.5) { [unowned self] () -> Void in
            self.shareSheetView.alpha = 0
            self.shareSheetView.hidden = true
            self.shareSheetView.transform = CGAffineTransformMakeTranslation(0, 234)
            self.dialogView.transform = CGAffineTransformMakeScale(1, 1)
        }
    }
    
    private func hideUserPopoverView() {
        SpringAnimation.spring(0.5) { [unowned self] () -> Void in
            self.userPopoverView.hidden = true
        }
    }

    private func showMask() {
        self.maskButton.hidden = false
        self.maskButton.alpha = 0
        SpringAnimation.spring(0.5) { [unowned self] () -> Void in
            self.maskButton.alpha = 1
        }
    }
}
