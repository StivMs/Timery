//
//  ViewController.swift
//  Timer
//
//  Created by Stivan Mersho on 2020-05-19.
//  Copyright © 2020 Stivan Mersho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    var seconds = 30
    // Timer object
    var timer = Timer()
    var isTimerRunning = false
    var isResumePressed = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Timer by Stivan"
        pauseButton.isEnabled = false
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if(isTimerRunning == false) {
            runTimer()
            startButton.isEnabled = false
            resetButton.isEnabled = true
            resetButton.setTitleColor(.darkGray, for: .disabled)

        }
    }
    
    
    @IBAction func pauseButtonTapped(_ sender: Any) {
        // Check is it's first time button is pressed
        // Pause timer if it's first time
        if (isResumePressed == false) {
            timer.invalidate()
            isResumePressed = true
            pauseButton.setTitle("Resume", for: .normal)
        } else {
            // Resume timer
            runTimer()
            isResumePressed = false
            pauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        timer.invalidate()
        seconds = 30
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        resetButton.isEnabled = false
        
    }
    
    // Func for firing the timer
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
        
    }
    
    // Change the label with seconds going down
    @objc func updateTimer(){
        // Alert when timer is finised (under 1 second left)
        // Reset the timer to ready to next tound
        if seconds < 1 {
            timer.invalidate()
            resetButtonTapped(self)

            let ac = UIAlertController(title: "Time's up!", message: "Timer has finished, have fun", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(ac, animated: true)
            
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        
    }
    
    
    // Convert the label to show hours, minutes and second
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 36000
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    
}

