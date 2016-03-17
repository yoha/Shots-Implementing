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
    }

    // MARK: - UIViewController Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToHomeViewController" {
            guard let validHomeViewController = segue.destinationViewController as? HomeViewController else { return }
            validHomeViewController.data = self.data
            validHomeViewController.indexForData = self.indexForData
        }
    }
}
