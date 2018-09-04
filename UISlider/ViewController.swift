//
//  ViewController.swift
//  UISlider
//
//  Created by Citizen on 03.09.2018.
//  Copyright © 2018 Citizen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var volumSlider: UISlider!
    @IBOutlet weak var audioSlider: UISlider!
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBOutlet weak var audioValueLabel: UILabel!
    @IBOutlet weak var volumValueLabel: UILabel!
    @IBOutlet weak var rateValueLabel: UILabel!
    @IBOutlet weak var backgroundColorLabel: UILabel!
    
    var player = AVAudioPlayer()
    private let toPercent: Float = 100
    private let maxColorValue: Float = 255
    private let toSeconds: Float = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let auidioPath = Bundle.main.path(forResource: "Human", ofType: "mp3")
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateAudioSlider), userInfo: nil, repeats: true)
        
        try! player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: auidioPath!))
        setValues()
        
        
        
    }
    
    @objc func updateAudioSlider() {
        audioSlider.value = Float(player.currentTime)
        let audioMinutes = Int(player.currentTime)%3600/60
        let audioSeconds = Int(player.currentTime)%3600%60
        audioValueLabel.text = String(format:"%02i:%02i", audioMinutes, audioSeconds)
        
    }
    
    func setValues() {
        rateSlider.setValue(player.rate, animated: false)
        audioSlider.maximumValue = Float(player.duration)
        rateSlider.maximumValue = 3
        player.enableRate = true
        volumValueLabel.text = String("\(Int(volumSlider.value * toPercent))%")
        rateValueLabel.text = String("\(Int(rateSlider.value * toPercent))%")
        audioValueLabel.text = String(player.currentTime)
        sliderChangeColor()
    }
    
    func sliderChangeColor() {
        redSlider.thumbTintColor = UIColor.red
        greenSlider.thumbTintColor = UIColor.green
        blueSlider.thumbTintColor = UIColor.blue
        redSlider.tintColor = UIColor.red
        greenSlider.tintColor = UIColor.green
        blueSlider.tintColor = UIColor.blue
        redSlider.maximumValue = maxColorValue
        greenSlider.maximumValue = maxColorValue
        blueSlider.maximumValue = maxColorValue
    }
    
    func changeBackgroundColorLabel() {
        self.backgroundColorLabel.text = String("red - \(Int(redSlider.value))\t\t green - \(Int(greenSlider.value))\t\t blue \(Int(blueSlider.value))")
    }
    
    @IBAction func playPauseButton(_ sender: Any) {
        if player.isPlaying{
            playPauseButton.setTitle("▶", for: .normal)
            self.player.pause()
        } else {
            playPauseButton.setTitle("▮▮", for: .normal)
            self.player.play()
        }
    }
    
    @IBAction func audioSliderAction(_ sender: UISlider) {
        player.currentTime = TimeInterval(audioSlider.value)
    }
    
    @IBAction func volumSliderAction(_ sender: UISlider) {
        player.volume = self.volumSlider.value
        volumValueLabel.text = String("\(Int(sender.value * toPercent))%")
    }
    
    @IBAction func rateSliderAction(_ sender: UISlider) {
        player.rate = sender.value
        rateValueLabel.text = String("\(Int(rateSlider.value * toPercent))%")
    }
    
    @IBAction func redSliderAction(_ sender: UISlider) {
        view.backgroundColor = UIColor(red: CGFloat(sender.value/maxColorValue), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
        changeBackgroundColorLabel()
    }
    
    @IBAction func greenSliderAction(_ sender: UISlider) {
        view.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(sender.value/maxColorValue), blue: CGFloat(blueSlider.value), alpha: 1)
        changeBackgroundColorLabel()
    }
   
    @IBAction func blueSliderAction(_ sender: UISlider) {
         view.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(sender.value/maxColorValue), alpha: 1)
        changeBackgroundColorLabel()
    }
 
}

