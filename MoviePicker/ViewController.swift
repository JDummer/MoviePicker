//
//  ViewController.swift
//  MoviePicker
//
//  Created by Jonathan Dummer on 11/6/15.
//  Copyright © 2015 Jonathan Dummer. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController
{
    @IBOutlet weak var randomMovieLabel: UILabel!
    
    @IBAction func showMoviesButton(sender: AnyObject)
    {
        //don't delete
    }
    @IBAction func showMoviesButtonPressed(sender: AnyObject)
    {
        
    }
    
    @IBAction func pickAMovieButton(sender: AnyObject)
    {
        let randomNum = Int(arc4random_uniform(UInt32(MovieCore.listofMovies.count)))
        self.randomMovieLabel.text = "\(MovieCore.listofMovies[randomNum].objectForKey("movieName") as! String!)"
    }

    override func viewWillAppear(animated: Bool)
    {
        let query = PFQuery(className:"MovieList")
        query.whereKey("watched", equalTo: false)
        query.orderByAscending("movieName")
        query.findObjectsInBackgroundWithBlock { (objects : [PFObject]?, error:NSError?) -> Void in
            if(objects != nil)
            {
                MovieCore.listofMovies = objects!
            }
            else
            {
                print("None Found")
            }
        }
        
        let querytwo = PFQuery(className:"MovieList")
        querytwo.whereKey("watched", equalTo: true)
        querytwo.orderByAscending("movieName")
        querytwo.findObjectsInBackgroundWithBlock { (objects : [PFObject]?, error:NSError?) -> Void in
            if(objects != nil)
            {
                MovieCore.watchedMovies = objects!
            }
            else
            {
                print("None Found")
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.randomMovieLabel.text = ""
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
