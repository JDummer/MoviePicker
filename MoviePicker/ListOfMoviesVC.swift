//
//  ListOfMoviesViewController.swift
//  MoviePicker
//
//  Created by Jonathan Dummer on 11/12/15.
//  Copyright © 2015 Jonathan Dummer. All rights reserved.
//

import UIKit
import Parse

class ListOfMoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var movieWasDeletedLabel: UILabel!
    var theRow = -1
    @IBOutlet weak var theTableView : UITableView!
    
    @IBAction func backButtonPressed(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func deleteMovieButtonPressed(sender: AnyObject)
    {
        //gets the objectId of the movie selected in the table view
        let movieName = MovieCore.listofMovies[theRow].objectForKey("movieName")
        let movieID = MovieCore.listofMovies[theRow].objectId as! String!
        
        //queries for the movie id and changes the watched boolean to true so it doesn't show it table view
        let query = PFQuery(className: "MovieList")
        query.getObjectInBackgroundWithId(movieID)
            {
                (MovieList: PFObject?, error: NSError?) -> Void in
                if error != nil
                {
                    print(error)
                }
                else if let MovieList = MovieList
                {
                    MovieList["watched"] = true
                    MovieList.saveInBackground()
                    self.movieWasDeletedLabel.text = "You watched \(movieName as! String!)"
                    //not working yet self.theTableView.reloadData()
                }
        }
    }


    
    @IBOutlet weak var movieTVLabel: UILabel!
    @IBOutlet weak var movieTVImage: UIImageView!
    
    override func viewWillAppear(animated: Bool)
    {
        movieWasDeletedLabel.text = ""
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return MovieCore.listofMovies.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel!.text = MovieCore.listofMovies[indexPath.row].objectForKey("movieName") as! String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.theRow = indexPath.row
    }

    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */

    /*
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //rollDetailCell is another NSObject
        print("getting cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as!
        
        // Configure the cell...
        let theParts = PhoneCore.theRowData[indexPath.row].componentsSeparatedByString("->")
        cell.movieTVLabel.text = theParts[1]
        //cell.movieTVImage =
        //cell.detailTextLabel?.text = theParts[0]
        return cell
    }
*/

   // override func didReceiveMemoryWarning()
    //{
      //  super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    //}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
