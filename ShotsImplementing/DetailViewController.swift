//
//  DetailViewController.swift
//  ShotsImplementing
//
//  Created by Yohannes Wijaya on 3/10/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - IBAction Methods
    
    @IBAction func backButtonDidTouch(sender: UIButton) {
        self.performSegueWithIdentifier("segueToHomeViewController", sender: self)
    }
    
    // MARK: - Stored Properties
    
    var data = Array<Dictionary<String, String>>()
    var indexForData = 0
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = UIImage(named: self.data[self.indexForData]["image"]!)
        self.avatarImageView.image = UIImage(named: self.data[self.indexForData]["avatar"]!)
        self.authorLabel.text = self.data[self.indexForData]["author"]
        self.descriptionTextView.text = self.data[self.indexForData]["text"]
        self.backButton.alpha = 0
        
        self.textViewWithFont(descriptionTextView, fontName: "Libertad", fontSize: 16, lineSpacing: 7)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.backButton.alpha = 1
        
        self.springScaleFrom(backButton!, x: -100, y: 0, scaleX: 0.5, scaleY: 0.5)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    // MARK: - UIViewController Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToHomeViewController" {
            guard let validHomeViewController = segue.destinationViewController as? HomeViewController else { return }
            validHomeViewController.data = self.data
            validHomeViewController.indexForData = self.indexForData
        }
    }
    
    // MARK: - Helper Methods
    
    private func springScaleFrom(view: UIView, x: CGFloat, y: CGFloat, scaleX: CGFloat, scaleY: CGFloat) {
        let translation = CGAffineTransformMakeTranslation(x, y)
        let scale = CGAffineTransformMakeScale(scaleX, scaleY)
        view.transform = CGAffineTransformConcat(translation, scale)
        
        SpringAnimation.spring(0.7) { () -> Void in
            let translation = CGAffineTransformMakeTranslation(0, 0)
            let scale = CGAffineTransformMakeScale(1, 1)
            view.transform = CGAffineTransformConcat(translation, scale)
        }
    }
    
    private func textViewWithFont(textView: UITextView, fontName: String, fontSize: CGFloat, lineSpacing: CGFloat) {
        let font = UIFont(name: fontName, size: fontSize)
        let text = textView.text
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSFontAttributeName, value: font!, range: NSMakeRange(0, attributedString.length))
        
        textView.attributedText = attributedString
    }
}
