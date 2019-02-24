//
//  ViewController.swift
//  BullsEye
//
//  Created by Artem Karmaz on 2/23/19.
//  Copyright © 2019 Artem Karmaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = Int.random(in: 1...100)
        slider.value = Float(currentValue)
        updateLabels()
        graph()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        //        targetLabel.text = "\(targetValue)"
    }
    
    func graph() {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        startNewRound()
        startNewGame()
        //        currentValue = lroundf(slider.value)
        //        targetValue = Int.random(in: 1...100)
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue) // absolute value
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        score += points
        
        
        //        var difference = currentValue - targetValue
        //        if difference < 0 {
        //            difference = difference * -1
        //        }
        //        if currentValue > targetValue {
        //            difference = currentValue - targetValue
        //        } else if targetValue > currentValue {
        //            difference = targetValue - currentValue
        //        } else {
        //            difference = 0
        //        }
        //
        //        let message = "The value of the slder is: \(currentValue)" + "\nThe target value is: \(targetValue)" + "\nThe difference is: \(difference)"
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {_ in self.startNewRound()}) // ассинхронность данных, вызов функции после нажатия кнопки
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
//        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
        //        print("The value of the slider is now: \(slider.value)")
        print("The value of the slider is now: \(currentValue)")
        
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
        
        graph()
    }
}

