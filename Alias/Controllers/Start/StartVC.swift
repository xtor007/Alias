//
//  StartVC.swift
//  Alias
//
//  Created by Anatoliy Khramchenko on 08.09.2022.
//

import UIKit

class StartVC: UIViewController {
    
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startAction(_ sender: Any) {
        let duration = TimeInterval(0.5)
        let startScale = 0.5
        let starScale = 15.0
        UIView.animate(withDuration: duration/2, delay: 0.2, options: .curveEaseOut) { //make button smaller
            self.startButton.transform = CGAffineTransform(scaleX: startScale, y: startScale)
        } completion: { isFinish in
            if isFinish {
                UIView.animate(withDuration: duration/2, delay: 0, options: .curveEaseIn) { //make star bigger
                    self.starImage.transform = CGAffineTransform(scaleX: starScale, y: starScale)
                    self.startButton.alpha = 0
                } completion: { isFinish in
                    if isFinish {
                        let gameVC = GameVC()
                        gameVC.modalPresentationStyle = .fullScreen
                        self.present(gameVC, animated: false) { //open game vc
                            self.startButton.transform = .identity
                            self.starImage.transform = .identity
                            self.startButton.alpha = 1
                        }
                    }
                }
            }
        }
    }

}
