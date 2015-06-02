//
//  ResultsViewController.swift
//  ProjectThree
//
//  Created by Marek Fořt on 01.02.15.
//  Copyright (c) 2015 Marek Fořt. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mainVC: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        // Init navigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
    
    }
    
    override func viewDidAppear(animated: Bool) {
        mainVC.resultsArray = mainVC.resultsArray.sorted {
            (resultOne: ResultModel, resultTwo: ResultModel) -> Bool in
            let resultOneDate = self.currentDateToNSDate(resultOne.date)
            let resultTwoDate = self.currentDateToNSDate(resultTwo.date)
            return resultOneDate.timeIntervalSince1970 > resultTwoDate.timeIntervalSince1970
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainVC.resultsArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ResultCell = tableView.dequeueReusableCellWithIdentifier("resultCell") as! ResultCell
        cell.resultLabel.text = mainVC.resultsArray[indexPath.row].result
        cell.dateLabel.text = mainVC.resultsArray[indexPath.row].date
        cell.numbersToResultLabel.text = mainVC.resultsArray[indexPath.row].numbersToResult
        cell.contentView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        mainVC.result = mainVC.resultsArray[indexPath.row].result
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func currentDateToNSDate(dateString: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.dateFromString(dateString)
        return date!
    }


    


}
