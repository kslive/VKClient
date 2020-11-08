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
    
    func convertDate(timeIntervalSince1970: Double) -> String{
        dateFormatter.dateFormat = "MM-dd-yyyy HH.mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = Date(timeIntervalSince1970: timeIntervalSince1970)
        return dateFormatter.string(from: date)
    }
}
