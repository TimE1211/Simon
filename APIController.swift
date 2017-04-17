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
  func apiControllerDidSend(results: [[String: Any]])
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
            self.delegate.apiControllerDidSend(results: highscoreDictionary)
        }
      }
    })
    task.resume()
  }
  
  func parseJSON(_ data: Data) -> [String: Any]?
  {
    do
    {
      let json = try JSONSerialization.jsonObject(with: data, options: [])
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
}

