//
//  HighscoreTableViewController.swift
//  Simon
//
//  Created by Timothy Hang on 4/16/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import UIKit
import Foundation

class HighscoreTableViewController: UITableViewController, APIControllerProtocol
{
  var highscores = [Highscore]()
  var apiController: APIController!
  
  override func viewDidLoad()
  {
    apiController = APIController(delegate: self)
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return highscores.count
  }


  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoreTableViewCell", for: indexPath) as! HighscoreTableViewCell
    
    let highscore = self.highscores[indexPath.row]
    cell.usernameLabel.text = highscore.username
    cell.scoreLabel.text = String(highscore.score)
  
    return cell
  }
  
  func apiControllerDidReceive(results: [[String: Any]])
  {
    for result in results
    {
      let highscore = Highscore(highscoreDictionary: result)
      highscores.append(highscore)
    }
    
    tableView.reloadData()
  }
}
