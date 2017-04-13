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
  var buttonOrderArray = [Int]()
  var correctbuttonOrderArray = [Int]()
  var round = 0 {
    didSet { roundLabel.text = "round " + String(round) }
  }
  var score = 0 {
    didSet { scoreLabel.text = "Score: \(score)" }
  }
  var index = 0
  
  @IBOutlet weak var redButton: UIButton!
  @IBOutlet weak var greenButton: UIButton!
  @IBOutlet weak var yellowButton: UIButton!
  @IBOutlet weak var blueButton: UIButton!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
  var buttons = [UIButton]()
  
  override func viewDidLoad()
  {
    buttons = [redButton, greenButton, yellowButton, blueButton]
    
    for button in buttons
    {
      button.alpha = 0.5
    }
    
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
    buttonTapped()
  }
  
  @IBAction func greenTapped(_ sender: UIButton)
  {
    buttonNumber = 1
    animateButtons()
    buttonTapped()
  }
  
  @IBAction func yellowTapped(_ sender: UIButton)
  {
    buttonNumber = 2
    animateButtons()
    buttonTapped()
  }
  
  @IBAction func blueTapped(_ sender: UIButton)
  {
    buttonNumber = 3
    animateButtons()
    buttonTapped()
  }
  
  func animateButtons()
  {
    var button = [redButton, greenButton, yellowButton, blueButton]
    UIView.animate(withDuration: 1, animations:{
      //      button[self.buttonNumber]?.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
      button[self.buttonNumber]?.alpha = 1
    },  completion: { finished in
      //      button[self.buttonNumber]?.transform = .identity
      button[self.buttonNumber]?.alpha = 0.5
    })
  }
  
  func buttonTapped()
  {
    if round != 0
    {
      buttonOrderArray.append(buttonNumber)
    }
    answerPressed()
  }
  
  func answerPressed()
  {
    if buttonOrderArray[index] == correctbuttonOrderArray[index]
    {
      index += 1
      if buttonOrderArray.count == correctbuttonOrderArray.count
      {
        nextRound()
        index = 0
        score += 1
      }
    }
    else if buttonOrderArray[index] != correctbuttonOrderArray[index]
    {
      gameOver()
    }
  }
  
  @IBAction func startTapped(_ sender: UIButton)        //start round func
  {
    if round == 0
    {
      round += 1
      correctbuttonOrderArray.append(Int(arc4random() % 3))
      var loopCount = 0
      
      for number in correctbuttonOrderArray
      {
        buttonNumber = number
        Timer.scheduledTimer(withTimeInterval: TimeInterval(loopCount), repeats: false)
        { timer in
          switch number
          {
            case 0:
              self.animateButtons()
            case 1:
              self.animateButtons()
            case 2:
              self.animateButtons()
            case 3:
              self.animateButtons()
            default:
              self.scoreLabel.text = "Error"
          }
          timer.invalidate()
        }
        loopCount += 1
      }
    }
  }

  func nextRound()
  {
    if round >= 10
    {
      scoreLabel.text = "Congratulations You Win"
      roundLabel.text = "Congratulations You Win"
    }
    else
    {
      round += 1
      correctbuttonOrderArray.append(Int(arc4random() % 3))
      var loopCount = 0
      
      for number in correctbuttonOrderArray
      {
        buttonNumber = number
        Timer.scheduledTimer(withTimeInterval: TimeInterval(loopCount), repeats: false)
        { timer in
          switch number
          {
            case 0:
              self.animateButtons()
            case 1:
              self.animateButtons()
            case 2:
              self.animateButtons()
            case 3:
              self.animateButtons()
            default:
              self.scoreLabel.text = "Error"
          }
          timer.invalidate()
        }
        loopCount += 1
      }
    }
  }
  func gameOver()
  {
    buttonOrderArray = [Int]()
    correctbuttonOrderArray = [Int]()
    round = 0
    index = 0
    score = 0

    scoreLabel.text = "Game Over"
    roundLabel.text = "Game Over"
  }
}

