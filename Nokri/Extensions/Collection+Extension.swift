//
//  Collection+Extension.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/7/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

extension Collection where Iterator.Element == [String:Any] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:Any]],
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}
