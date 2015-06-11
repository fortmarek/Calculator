//
//  Result.swift
//  Calculator
//
//  Created by Marek Fořt on 11.06.15.
//  Copyright (c) 2015 Marek Fořt. All rights reserved.
//

import Foundation
import CoreData

class Result: NSManagedObject {

    @NSManaged var date: String
    @NSManaged var result: String
    @NSManaged var numbersToResult: String

}
