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
        return "No Date"
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
    case focDate = "focDate"
    case onsaleDate = "onsaleDate"
    case title = "title"
    case issueNumber = "issueNumber"
    case modified = "modified"
    var id: String { self.rawValue }
}

enum PrivacyBool: String, Identifiable, CaseIterable {
    case `true` = "true"
    case `false` = "false"
    var id: String { self.rawValue }
}
