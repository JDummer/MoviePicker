//
//  AddAMovieVC.swift
//  MoviePicker
//
//  Created by Jonathan Dummer on 11/28/15.
//  Copyright © 2015 Jonathan Dummer. All rights reserved.
//

import UIKit
import Parse

class AddAMovieVC: UIViewController
{

    @IBOutlet weak var addAMovieTF: UITextField!
    @IBOutlet weak var whoAddedTF: UITextField!
    @IBOutlet weak var movieWasAddedLabel: UILabel!
    
    var movieName : String?
    var whoAdded : String?
    
    @IBAction func addAMovieButtonPressed(sender: AnyObject)
    {
        movieName = addAMovieTF.text!
        whoAdded = whoAddedTF.text!
        
        let movie = PFObject(className:"MovieList")
        movie["movieName"] = movieName
        movie["watched"] = false
        movie["whoAdded"] = whoAdded
        movie.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success)
            {
                // The object has been saved.
                self.movieWasAddedLabel.text = "The movie was added!"
                self.addAMovieTF.text = ""
                self.whoAddedTF.text = ""
            }
            else
            {
                // There was a problem, check error.description
                self.movieWasAddedLabel.text = "There was an error"
            }
        }
    }
    
    @IBAction func backButtonPressed(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.addAMovieTF.becomeFirstResponder()
        self.movieWasAddedLabel.text = ""
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
