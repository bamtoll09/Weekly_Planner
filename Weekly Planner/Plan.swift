//
//  Plan.swift
//  Weekly Planner
//
//  Created by Sunrin on 2017. 1. 3..
//  Copyright © 2017년 Bamtoll. All rights reserved.
//

struct Plan {
    
    var day: Day
    var startTime: Int
    var endTime: Int
    var check: Bool
    var title: String
    var context: String?
    
    init(day: Day, startTime: Int, endTime: Int, title: String, context: String?) {
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.check = false
        self.title = title
        
        guard let _context = context else { return }
        self.context? = _context
    }
    
}

enum Day {
    case Sun
    case Mon
    case Tue
    case Wed
    case Ths
    case Fri
    case Sat
}
