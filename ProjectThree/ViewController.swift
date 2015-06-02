//
//  ViewController.swift
//  ProjectThree
//
//  Created by Marek Fořt on 07.11.14.
//  Copyright (c) 2014 Marek Fořt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mark: String = ""
    var numText:String = "0"
    var x:Double = 0
    var y:Double = 0
    var result:String = ""
    var pi: Double = 3.14159265359
    var repeatingOperation: Bool = false
    var equalsButton = true
    var resultsArray: [ResultModel] = []
    var repeatingAction: Bool = false
    var numberLabel = UILabel()
    var navigationBarButtonItem =  UIBarButtonItem()

    
   
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        // Init navigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationItem.leftBarButtonItem = navigationBarButtonItem
       
        
        //Init navigationBarItem
        
        navigationBarButtonItem.title = "<"
        navigationBarButtonItem.action = "resultsButtonTapped:"
        navigationBarButtonItem.tintColor = UIColor.blackColor()
        navigationBarButtonItem.target = self
        
        
        //Init Buttons
        
        var buttonsInRow = 0
        var numberOfRows = 0
        let kMaxInRow = 3
        
        for var i = 0; i < 18; i++ {
            var title = ""
            var action: Selector = ""
            switch i {
            case 0: title = "1"
            case 1: title = "2"
            case 2: title = "3"
            case 3: title = "4"
            case 4: title = "5"
            case 5: title = "6"
            case 6: title = "7"
            case 7: title = "8"
            case 8: title = "9"
            case 9: title = "="
            case 10: title = "0"
            case 11: title = "C"
            case 12: title = "."
            case 13: title = "x"
            case 14: title = "+/-"
            case 15: title = "+"
            case 16: title = "-"
            case 17: title = ":"
            default:
                title = "0"
            }
            let kHorizontalSpace: CGFloat = 15.0
            let kVerticalSpace: CGFloat = 8.0
            let kWidth: CGFloat = 75.0
            let kMargin: CGFloat = 160 - (kWidth + kWidth / 2 + kHorizontalSpace)
            
            let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            button.setBackgroundImage(UIImage(named: "button"), forState: UIControlState.Normal)
            button.opaque = true
            button.setTitle(title, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
            switch title {
            case "+/-": action = "signChangeButtonPressed:"
            case "C": action = "refreshButtonPressed:"
            case "x": action = "multiplicationButtonPressed:"
            case "-": action = "minusButtonPressed:"
            case "+": action = "plusButtonPressed:"
            case ":": action = "dividingButtonPressed:"
            case "=": action = "equalButtonPressed:"
            default:
                action = "numberButtonPressed:"
            }
            button.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.frame = CGRectMake(CGFloat(buttonsInRow) * (kWidth + kHorizontalSpace) + kMargin, CGFloat(numberOfRows) * (kWidth + kVerticalSpace) + 75, kWidth, kWidth)
            
            if buttonsInRow == 2 {
                buttonsInRow = 0
                numberOfRows++
            }
            else {
                buttonsInRow++
            }

            self.view.addSubview(button)
        }
        
        //Init Label
        
        numberLabel.frame = CGRectMake(0, 0, 280, 42.5)
        numberLabel.center = CGPoint(x: 160, y: 50)
        numberLabel.text = "0"
        numberLabel.textAlignment = NSTextAlignment.Center
        numberLabel.opaque = true
        numberLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        self.view.addSubview(numberLabel)
        
        
        
    }

    
    override func viewDidAppear(animated: Bool) {
        
        if result != "" {
            numText = result
        }
        numberLabel.text = numText
        x = stringAsDouble(result)
    }
    
    


    @IBAction func numberButtonPressed(sender:UIButton!) {
        let currentTitleString = sender.currentTitle!
        //Ensuring that there are not two dots in one number, eg: 9.87.899
        for character in numText {
            if character == "." && sender.currentTitle == "." {
                return
            }
        }
        if numText == "0" && sender.currentTitle! != "." || numberLabel.text == "Error" || repeatingAction == true  {
        
        numText = currentTitleString
        numberLabel.text = numText
        repeatingAction == false
        }
        else {
            numText += currentTitleString
            numberLabel.text = numText
        }
        if equalsButton == true {
            result = ""
        }
        if result != "" {
          y = stringAsDouble(numText)  
        }

        repeatingAction = false
    }



    @IBAction func equalButtonPressed(sender: UIButton) {
        if numText != "" {
            if repeatingOperation == true {
            }
            else {
                y = stringAsDouble(numText)
            }
            equal()
            repeatingOperation = true
            equalsButton = true
        }
    }

    
    @IBAction func minusButtonPressed(sender: UIButton) {
        actionButtonPressed("-")
    }
    @IBAction func plusButtonPressed(sender: UIButton) {
        actionButtonPressed("+")
    }
    @IBAction func multiplicationButtonPressed(sender: UIButton) {
        actionButtonPressed("x")
    }
    @IBAction func dividingButtonPressed(sender: UIButton) {
        actionButtonPressed(":")
    }
    @IBAction func piNumberButton(sender: UIButton) {
        numText = "\(pi)"
        numberLabel.text = numText
    }

    @IBAction func refreshButtonPressed(sender: UIButton) {
        x = 0
        y = 0
        result = ""
        numText = "0"
        numberLabel.text = numText
        mark = ""
        repeatingOperation = false
        repeatingAction = false
        equalsButton = true
    }
    

    @IBAction func signChangeButtonPressed(sender: UIButton) {
        /*
        if (numText as NSString).doubleValue > 0 {
            numText = "-" + numText
        }
        else if numText.hasPrefix("-"){
            let numResult = "\(-(numText as NSString).doubleValue)"
            numText = "\(isNumberDoubleOrInt(numResult))"
        }
        else {
        }

*/
        if numText == "0" {
            return
        }
        let numTextAsDouble = stringAsDouble(numText)
        let numTextToNegative = "-" + numText
        let numTextToPositive = isNumberDoubleOrInt("\(-numTextAsDouble)")
        let isNegative = numText.hasPrefix("-")
        let number = (isNegative ? numTextToPositive : numTextToNegative)
        numText = number
        numberLabel.text = numText
        result = ""
    }



    func actionButtonPressed (markString: String) {
        if equalsButton == true {
        x = stringAsDouble(numText)
        }

       if result == "" {
        y = stringAsDouble(numText)
        numText = ""
    }
    
       else if result == "Error" {
        x = 0
        numberLabel.text = "0"
        numText = ""
    }
       else {
        y = stringAsDouble(numText)
        }
        if equalsButton == true || repeatingAction == true {
        }
        else {
            equal()
        }
        equalsButton = false
        repeatingAction = true
        repeatingOperation = false
        mark = markString

    }
    
    
    func isNumberDoubleOrInt(number: String) -> String {
        let numberAsDouble = (number as NSString).doubleValue
        let numberAsInteger = (number as NSString).integerValue
        if numberAsDouble == Double(numberAsInteger) {
            return "\(numberAsInteger)"
        }
        else {
            return "\(numberAsDouble)"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showResultsViewController" {
            let resultsVC: ResultsViewController = segue.destinationViewController as! ResultsViewController
            resultsVC.mainVC = self
            
        }
    }
    
    @IBAction func resultsButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showResultsViewController", sender: self)
    }
    
    func currentDate() -> String {
        var todaysDate:NSDate = NSDate()
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var dateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        /* OR
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour, fromDate: todaysDate)
        let hour = components.hour
        */
        return dateInFormat
    }
    
    func equal() {
        switch mark {
        case "-":
            result = "\(x - y)"
        case "x":
            result = "\(x * y)"
        case ":" where y != 0:
                result = "\(x / y)"
        case ":" where y == 0:
                result = "Error"
                numText = result
                numberLabel.text = numText
                return
        default:
            result = "\(x + y)"
        }
        result = isNumberDoubleOrInt(result)
        numText = result
        numberLabel.text = numText
        var xAsString = isNumberDoubleOrInt("\(x)")
        var yAsString = isNumberDoubleOrInt("\(y)")
        let newResult = ResultModel(result: result, numbersToResult: xAsString + " " + mark + " " +  yAsString, date: currentDate())
        resultsArray.append(newResult)
        x = stringAsDouble(result)
    }
    func stringAsDouble (string: String) -> Double {
        return (string as NSString).doubleValue
    }
    
}

