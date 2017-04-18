//
//  Highscore.swift
//  Simon
//
//  Created by Timothy Hang on 4/16/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import Foundation

class Highscore
{
  var username: String
  var score: Double
  
  init(highscoreDictionary: [String: Any])
  {
    username = highscoreDictionary["displayname"] as? String ?? ""
    score = highscoreDictionary["score"] as! Double
  }

}
