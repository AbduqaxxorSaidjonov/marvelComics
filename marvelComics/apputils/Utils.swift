//
//  Utils.swift
//  marvelComics
//
//  Created by Abduqaxxor on 7/10/22.
//

import Foundation
import UIKit

class Utils{
    static func dateFormatter(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let stringToDate = dateFormatter.date(from: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let resultDate: String
        if stringToDate == nil{
            return ""
        }else{
            resultDate = formatter.string(from: stringToDate ?? Date())
        }
        return resultDate
    }
}

extension UIScreen{
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
}

extension Data{
    var prettyPrintedJSONString: NSString?{
        guard let object = try? JSONSerialization.jsonObject(with: self,options: []),
                let data = try? JSONSerialization.data(withJSONObject: object,options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else{
            return nil
        }
        return prettyPrintedString
    }
}
