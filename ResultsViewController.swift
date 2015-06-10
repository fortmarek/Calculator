//
//  ResultsViewController.swift
//  ProjectThree
//
//  Created by Marek Fořt on 01.02.15.
//  Copyright (c) 2015 Marek Fořt. All rights reserved.
//

import UIKit
import CoreData

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mainVC: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let backgroundImage = UIImage(named: "background")
        let imageView = UIImageView()
        imageView.image = backgroundImage
        tableView.backgroundView = imageView
        let navigationControllerImage = UIImage(named: "navigation")
        self.navigationController?.navigationBar.setBackgroundImage(navigationControllerImage, forBarMetrics: .Default)


    
    }
    
    override func viewDidAppear(animated: Bool) {
        /*  mainVC.resultsArray = mainVC.resultsArray.sorted {
            (resultOne: ResultModel, resultTwo: ResultModel) -> Bool in
            let resultOneDate = self.currentDateToNSDate(resultOne.date)
            let resultTwoDate = self.currentDateToNSDate(resultTwo.date)
            return resultOneDate.timeIntervalSince1970 > resultTwoDate.timeIntervalSince1970
}*/
      //  tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let objectArray: [AnyObject]? = fetchedResultsController.fetchedObjects
        return objectArray!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ResultCell = tableView.dequeueReusableCellWithIdentifier("resultCell") as! ResultCell
        let result = fetchedResultsController.objectAtIndexPath(indexPath) as! Result
        cell.resultLabel.text = result.result
        cell.dateLabel.text = result.date
        

        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        mainVC.result = mainVC.resultsArray[indexPath.row].result
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
    func currentDateToNSDate(dateString: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.dateFromString(dateString)
        return date!
    }

    var fetchedResultsController: NSFetchedResultsController {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let request = NSFetchRequest(entityName: "Result")
        let sortDescriptor = NSSortDescriptor(key: "result", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        let resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context!, sectionNameKeyPath: "result" , cacheName: nil)
        resultsController.performFetch(nil)
        resultsController.delegate = self

        return resultsController
    }
    
    func numberOfObjects () -> Int {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var request = NSFetchRequest(entityName: "Result")
        var error: NSError? = nil
        var results: NSArray = managedObjectContext.executeFetchRequest(request, error: &error)!
        var i: Int = 0
        for res in results{
            i++
        }
        let objectArray: [AnyObject]? = fetchedResultsController.fetchedObjects
        return objectArray!.count
    }

    


}
