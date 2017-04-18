//
//  APIController.swift
//  Simon
//
//  Created by Timothy Hang on 4/16/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import Foundation

protocol APIControllerProtocol
{
  func apiControllerDidReceive(results: [[String: Any]])
}

class APIController
{
  var delegate: APIControllerProtocol
  
  init(delegate: APIControllerProtocol)
  {
    self.delegate = delegate
  }
  
  func searchHighscore()
  {
    let urlPath = "http://67.205.186.213/api/v1/highscores"
    let url = URL(string: urlPath)!
    let session = URLSession.shared
    let task = session.dataTask(with: url, completionHandler: {data, response, error -> Void in
      print("Task completed")
      if let error = error
      {
        print(error.localizedDescription)
      }
      else if let data = data,
        let dictionary = self.parseJSON(data),
        let highscoreDictionary = dictionary["highscores"] as? [[String: Any]]
      {
        DispatchQueue.main.async
          {
            self.delegate.apiControllerDidReceive(results: highscoreDictionary)
        }
      }
    })
    task.resume()
  }
  
  func parseJSON(_ data: Data) -> [String: Any]?
  {
    do
    {
      let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
      if let dictionary = json as? [String: Any]
      {
        return dictionary
      }
      else
      {
        return nil
      }
    }
    catch
    {
      print(error)
      return nil
    }
  }
  
  static func postScoreToLeaderboard(score: Int, username: String)
  {
    let leaderboardAPIUrlString = "http://67.205.186.213/api/v1/save"
    var request = URLRequest(url: URL(string: leaderboardAPIUrlString)!)
    request.httpMethod = "POST"
    let paramString = "displayname=\(username)&username=TKH&score=\(score)"
    request.httpBody = paramString.data(using: .utf8)
    
    URLSession.shared.dataTask(with: request) {
      data, response, error in
      if let error = error
      {
        print(error.localizedDescription)
      }
      else
      {
        do
        {
          if let errorDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
          {
            if let error = errorDictionary["error"] as? String
            {
              if error != "Score record saved."
              {
                print("Score was not saved: \(error)")
              }
            }
          }
        } catch
        {
          print(error.localizedDescription)
        }
      }
    }.resume()
  }
}

