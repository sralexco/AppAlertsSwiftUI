//
//  Date.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 19/03/25.
//
import SwiftUI

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        dateformat.timeZone = TimeZone(abbreviation: "UTC")
        return dateformat.string(from: self)
    }
    
    func convertUTCtoLocal(format: String, date:String) -> String {
         let dateformat = DateFormatter()
         dateformat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" 
         dateformat.timeZone = TimeZone(abbreviation: "UTC")
        
         let dt = dateformat.date(from: date)
         dateformat.timeZone = TimeZone.current
         dateformat.dateFormat = format
         return dateformat.string(from: dt!)
     }
    
    func byFormat(format: String, date:String) -> String {
         let dateformat = DateFormatter()
         dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
         dateformat.timeZone = TimeZone.current
         let dt = dateformat.date(from: date)
         dateformat.dateFormat = format
         return dateformat.string(from: dt!)
     }
}
