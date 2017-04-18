//
//  LoginViewController.swift
//  Simon
//
//  Created by Timothy Hang on 4/16/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
  @IBOutlet weak var usernameTextField: UITextField!
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    let username = usernameTextField.text
    if segue.identifier == "LoginSegue"
    {
      let simonVC = segue.destination as! SimonViewController
      simonVC.username = username!
    }
  }
  
}
