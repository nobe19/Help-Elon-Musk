//
//  ViewController.swift
//  Help Elon Musk
//
//  Created by Nipuni Obe on 4/12/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var rocketImageView: UIImageView!
    var imageNumber = 0
    let totalImages = 5
    var yAtLanding: CGFloat!
    var audioPlayer: AVAudioPlayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        yAtLanding = rocketImageView.frame.origin.y
    }
    
    func playSound(name: String) {
        if let sound = NSDataAsset(name: name) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("😡 ERROR: \(error.localizedDescription) Couldn't initialize AVAudioPlayer object.")
            }
        } else {
            print("😡 ERROR: Couldn't read data from file sound0")
        }
    }

    @IBAction func rocketTapped(_ sender: UITapGestureRecognizer) {
        imageNumber += 1
        if imageNumber >= totalImages {
            imageNumber = 0
        }
        rocketImageView.image = UIImage(named: "rocket\(imageNumber)")
    }
    @IBAction func blastOffPressed(_ sender: UIButton) {
        
        if rocketImageView.frame.origin.y < yAtLanding {
            playSound(name: "rocketsound")
            sender.setTitle("Blast Off!", for: .normal)
            
            
            UIView.animate(withDuration: 2.0, animations: {
                self.rocketImageView.frame.origin.y = self.yAtLanding
            }) { _ in
                self.audioPlayer.stop()
            }
        } else {
            playSound(name: "rocketsound")
            sender.setTitle("Return", for: .normal)
            UIView.animate(withDuration: 2.0, animations: {
                self.rocketImageView.frame.origin.y = -self.rocketImageView.frame.height
            }) { _ in
                self.audioPlayer.stop()
            }
        }
    }
}

