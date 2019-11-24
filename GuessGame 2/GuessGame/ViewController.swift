//
//  ViewController.swift
//  GuessGame
//
//  Created by Apple on 5.10.2019.
//  Copyright © 2019 Melike. All rights reserved.
//

import UIKit
extension ViewController: GuessGameHelperDelegate{
    func updateGuessPlaceholder(placeholder: String) {
        guess.placeholder = placeholder
    }
    func updateGuessInputText(text: String) {
        guess.text = text
    }
    func updateInfo0(text: String) {
        info0.text = text
    }
    func updateInfo1(text: String) {
        info1.text = text
    }
    func updateImage(imageName: String) {
        image.image = UIImage(named:imageName )
    }
    func updateRemainingLifesInfo(text: String) {
        RemainingLifesInfo.text = text
    }
    func updateButtonText(text: String) {
        buttonText.setTitle(text, for: .normal)
    }
}

class ViewController: UIViewController {
    let guessGameHelper = GuessGameHelper()
    var lifes: Int = 3;
    var number: Int = 0;
    
    @IBOutlet weak var info0: UILabel!
    @IBOutlet weak var info1: UILabel!
    @IBOutlet weak var RemainingLifesInfo: UILabel!
    @IBOutlet weak var buttonText: UIButton!
    @IBOutlet weak var guess: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessGameHelper.delegate = self
    }
    
    @IBAction func play(_ sender: Any) {
        if let buttonTitle = buttonText.title(for: .normal) {
            if (buttonTitle == "PLAY") {
                guessGameHelper.initializeGame()
                updateGuessPlaceholder(placeholder: "Enter your guess")
                updateButtonText(text: "Guess")
            } else {
                if let guessText = guess.text{
                    let guessNum = guessGameHelper.validateTheGuess(guess: guessText)
                    if(guessNum != -1) {
                        guessGameHelper.checkTheGuess(guess: guessNum)
                    }
                }
            }
        }
    }
}

