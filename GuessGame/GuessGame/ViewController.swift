//
//  ViewController.swift
//  GuessGame
//
//  Created by Apple on 5.10.2019.
//  Copyright © 2019 Melike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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
        // Do any additional setup after loading the view.
    }
    func initializeGame() {
        number = Int.random(in: 1 ..< 10)
        print(number)
        lifes = 3;
        image.image = UIImage(named: "question")
        info0.text = "I have a number from 1 to 10 in my mind."
        info1.text = "Guess it if you can."
        guess.text = ""
    }
    @IBAction func play(_ sender: Any) {
        if let buttonTitle = buttonText.title(for: .normal) {
            if (buttonTitle == "PLAY") {
                initializeGame()
                guess.placeholder = "Enter your guess";
                buttonText.setTitle("Guess", for: .normal)
                RemainingLifesInfo.text="You have \(lifes) chances"
            } else {
                let check = validateTheGuess();
                if(check != -1) {
                    if (check == number) {
                        info0.text = "You've found it"
                        info1.text = "Wanna play again?"
                        image.image = UIImage(named: "tick")
                        RemainingLifesInfo.text=""
                        buttonText.setTitle("PLAY", for: .normal)
                    } else if (check > number) {
                        lifes -= 1
                        image.image = UIImage(named: "down")
                        info1.text = "Your guess is greater than my number"
                        RemainingLifesInfo.text="You have \(lifes) chances"
                    } else {
                        lifes -= 1
                        image.image = UIImage(named: "up")
                        info1.text = "My number is greater than your guess"
                        RemainingLifesInfo.text="You have \(lifes) chances"
                    }
                    if (lifes <= 0) {
                        image.image = UIImage(named: "x")
                        info0.text = "Game is over"
                        info1.text = "Wanna play again?"
                        RemainingLifesInfo.text=""
                        buttonText.setTitle("PLAY", for: .normal)
                    }
                }
            }
        }
    }
    func validateTheGuess() -> Int {
        if let guessText = guess.text {
            let num = Int(guessText)
            if (num == nil) {
                guess.text = ""
                guess.placeholder = "Please enter a valid integer";
                return -1;
            } else {
                if (num! <= 10 && num! >= 1) {
                    return num!;
                }
            }
        }
        guess.text = ""
        guess.placeholder = "Please enter a valid integer";
        return -1;
    }
}

