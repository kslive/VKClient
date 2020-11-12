//
//  DateFormatterVK.swift
//  VK Client
//
//  Created by Eugene Kiselev on 08.11.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class DateFormatterVK {
    
    let dateFormatter = DateFormatter()
    
    func convertDate(timestamp: Double) -> String{
        dateFormatter.dateFormat = "MM-dd-yyyy HH.mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }
}
