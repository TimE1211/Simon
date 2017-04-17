//
//  HighscoreTableViewController.swift
//  Simon
//
//  Created by Timothy Hang on 4/16/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import UIKit

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
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int
  {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    // #warning Incomplete implementation, return the number of rows
    return highscores.count
  }


  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoreTableViewCell", for: indexPath) as! HighscoreTableViewCell
    
    let highscore = self.highscores[indexPath.row]
    reloadCell(cell: cell , with: highscore)
  
    return cell
  }
  
  func apiControllerDidSend(results: [[String: Any]])
  {
    for result in results
    {
      let highscore = Highscore(highscoreDictionary: result)
      highscores.append(highscore)
    }
    
    tableView.reloadData()
  }
  
  func reloadCell(cell: HighscoreTableViewCell, with highscore: Highscore)
  {
    cell.usernameLabel.text = highscore.username
    cell.scoreLabel.text = String(highscore.score)
  }
}
