//
//  Handlers.swift
//  Simon
//
//  Created by Timothy Hang on 4/16/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import Foundation
import StORM
import PerfectHTTP
import SQLiteStORM

func processSaveScore(request: HTTPRequest, _ response: HTTPResponse)
{
  response.setHeader(.contentType, value: "application/json")
  var responseDictionary = [String: String]()
  
  guard let theScore = Int(request.param(name: "score")!),
    let theUserName = request.param(name: "username"),
    let theDisplayName = request.param(name: "displayname") else        //like if else statement
  {
    response.status = .badRequest
    responseDictionary["error"] = "Please supply values"
    
    do {
      try response.setBody(json: responseDictionary)
    }catch
    {
      print(error)
    }
    response.completed()
    return
  }
  
  let aScore = Score(connect)
  aScore.score = theScore
  aScore.userName = theUserName
  aScore.displayName = theDisplayName
  
  do {
    try aScore.save()
    responseDictionary["error"] = "Score record saved."
  } catch
  {
    print(error)
    responseDictionary["error"] = String(describing: error)
  }
  
  do {
    try response.setBody(json: responseDictionary)
  } catch
  {
    print(error)
  }
  
  response.completed()
}

func getHighScores(request: HTTPRequest, _ response: HTTPResponse)
{
  response.setHeader(.contentType, value: "application/json")
  
  var responseDictionary = [String: Any]()
  
  let scores = Score(connect)
  let cursor = StORMCursor(limit: 10, offset: 0)
  
  do {
    try scores.select(columns: ["username", "displayname", "score"], whereclause: "score > :1", params: [0], orderby: ["score DESC"], cursor: cursor)
    // whereclause = filter, parameters = none, orderby score descending
    var resultArray = [[String: Any]]()
    
    for row in scores.rows()
    {
      var aScoreDictionary = [String: Any]()
      aScoreDictionary["username"] = row.userName
      aScoreDictionary["displayname"] = row.displayName
      aScoreDictionary["score"] = row.score
      resultArray.append(aScoreDictionary)
    }
    
    responseDictionary["highscores"] = resultArray
  } catch
  {
    print(error)
  }
  
  do {
    try response.setBody(json: responseDictionary)
  } catch
  {
    print(error)
  }
  response.completed()
}
