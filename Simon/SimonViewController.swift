//
//  ViewController.swift
//  Simon
//
//  Created by Timothy Hang on 4/12/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import UIKit

class SimonViewController: UIViewController
{
  var buttonNumber = Int()
  var blurEffectNumber = Int()
  var buttonOrderArray = [Int]()
  var correctbuttonOrderArray = [Int]()
  var round = 0
  var count = 0
  var score = 0
  
  @IBOutlet weak var redButton: UIButton!
  @IBOutlet weak var greenButton: UIButton!
  @IBOutlet weak var yellowButton: UIButton!
  @IBOutlet weak var blueButton: UIButton!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
  override func viewDidLoad()
  {
    redButton.alpha = 0.5
    greenButton.alpha = 0.5
    yellowButton.alpha = 0.5
    blueButton.alpha = 0.5
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }

  @IBAction func redTapped(_ sender: UIButton)
  {
    buttonNumber = 0
    animateButtons()
    buttonOrderArray.append(buttonNumber)
    colorPressed()
  }
  
  @IBAction func greenTapped(_ sender: UIButton)
  {
    buttonNumber = 1
    animateButtons()
    buttonOrderArray.append(buttonNumber)
    colorPressed()
  }
  
  @IBAction func yellowTapped(_ sender: UIButton)
  {
    buttonNumber = 2
    animateButtons()
    buttonOrderArray.append(buttonNumber)
    colorPressed()
  }
  
  @IBAction func blueTapped(_ sender: UIButton)
  {
    buttonNumber = 3
    animateButtons()
    buttonOrderArray.append(buttonNumber)
    colorPressed()
  }
  
  @IBAction func startTapped(_ sender: UIButton)        //start round func
  {
    round += 1
    roundLabel.text = "round" + String(round)
    correctbuttonOrderArray.append(Int(arc4random() % 3))
    
    for _ in 0..<correctbuttonOrderArray.count
    {
      for number in correctbuttonOrderArray
      {
        switch number
        {
        case 0:
          redTapped(redButton)
        case 1:
          greenTapped(greenButton)
        case 2:
          yellowTapped(yellowButton)
        case 3:
          blueTapped(blueButton)
        default:
          scoreLabel.text = "Error"
        }
      }
      buttonOrderArray = [Int]()
    }
  }
  
  func animateButtons()
  {
    var button = [redButton, greenButton, yellowButton, blueButton]
    UIView.animate(withDuration: 0.5, animations: {
      button[self.buttonNumber]?.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
      button[self.buttonNumber]?.alpha = 1
    },  completion: { finished in
      button[self.buttonNumber]?.transform = .identity
      button[self.buttonNumber]?.alpha = 0.5
    })
  }
  
  func colorPressed()
  {
    count += 1
    if count == round && buttonOrderArray == correctbuttonOrderArray
    {
      count = 0
      nextRound()
      score += 1
      scoreLabel.text = "Score:" + String(score)
    }
    else if buttonOrderArray != correctbuttonOrderArray
    {
//      gameOver()
    }
  }
  
  func nextRound()
  {
    round += 1
    roundLabel.text = "round" + String(round)
    correctbuttonOrderArray.append(Int(arc4random() % 3))
    
    for _ in 0..<correctbuttonOrderArray.count
    {
      for number in correctbuttonOrderArray
      {
        switch number
        {
        case 0:
          redTapped(redButton)
        case 1:
          greenTapped(greenButton)
        case 2:
          yellowTapped(yellowButton)
        case 3:
          blueTapped(blueButton)
        default:
          scoreLabel.text = "error"
        }
      }
      buttonOrderArray = [Int]()
    }
  }
  func gameOver()
  {
    scoreLabel.text = "Game Over"
  }
}
//asdf










