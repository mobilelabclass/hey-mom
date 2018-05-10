//
//  FrequencyUpdateViewController.swift
//  HeyMom
//
//  Created by Nien Lam on 5/7/18.
//  Copyright © 2018 Line Break, LLC. All rights reserved.
//

import UIKit

class FrequencyUpdateViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var dayCountLabel: UILabel!
    @IBOutlet weak var frequencySlider: UISlider!
    @IBOutlet weak var unitLabel: UILabel!
    
    var didGoBack: (() -> ())?
    var didGoNext: (() -> ())?
    
    // Set to true if using VC from settings view.
    var isSettingsMode = false;
    
    var dayCount: Int! {
        didSet {
            dayCountLabel.text    = String(dayCount)
            frequencySlider.value = Float(dayCount)
            unitLabel.text        = dayCount > 1 ? "minutes" : "minute"
        }
    }

    // Get global singleton object.
    let appMgr = AppManager.sharedInstance
    
    // Haptic feedback
    var feedbackGenerator = UISelectionFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Buttons user only for onboarding flow.
        if isSettingsMode {
            backButton.isHidden = true
            nextButton.isHidden = true
        }
        
        feedbackGenerator.prepare()
    
        // Get day count from settings.
        dayCount = appMgr.dayCount
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction func handleBackButton(_ sender: UIButton) {
        self.didGoBack?()
    }

    @IBAction func handleNextButton(_ sender: UIButton) {
        self.didGoNext?()
    }

    // Hooked up to touchUpInside and touchUpOutside.
    @IBAction func handleFrequencySliderDidUpdate(_ sender: UISlider) {
        // Store day count.
        appMgr.dayCount = dayCount
    }
    
    @IBAction func handleFrequencySlider(_ sender: UISlider) {
        if dayCount == Int(sender.value) { return }
        
        dayCount = Int(sender.value)

        // Provide haptic feedback
        feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.selectionChanged()
        feedbackGenerator.prepare()
    }

    @IBAction func testNotification(_ sender: UIButton) {
        appMgr.testNotification()
    }
}
