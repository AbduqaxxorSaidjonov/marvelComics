//
//  Utils.swift
//  marvelComics
//
//  Created by Abduqaxxor on 7/10/22.
//

import Foundation
import UIKit

extension String {
    
    func toFormat(_ toFormat: String = "MMM d,yyyy", fromFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = fromFormat
        let stringToDate = dateFormatter.date(from: self)
        let formatter = DateFormatter()
        formatter.dateFormat = toFormat
        
        if let date = stringToDate {
            return formatter.string(from: date)
        }
        return ""
    }

    func stringToDate(fromFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = fromFormat
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
}


extension UIScreen {
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

enum Privacy: String, Identifiable, CaseIterable {
    case focDate = "FocDate"
    case onsaleDate = "Onsale Date"
    case title = "Title"
    case issueNumber = "Issue Number"
    case modified = "Modified"
    case _focDate = "-FocDate"
    case _onsaleDate = "-Onsale Date"
    case _title = "-Title"
    case _issueNumber = "-Issue Number"
    case _modified = "-Modified"
    var id: String { self.rawValue }
}

enum PrivacyBool: String, Identifiable, CaseIterable {
    case `true` = "true"
    case `false` = "false"
    var id: String { self.rawValue }
}
