//
//  CalendarExtension.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import Foundation

extension Calendar {
    
    func combineDate(_ date: Date, withTime time: Date) -> Date {
        var combinedComponents = dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let timeComponents = dateComponents([.hour, .minute], from: time)
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        return self.date(from: combinedComponents) ?? Date()
    }
    
    func splitDateAndTime(from date: Date) -> (date: Date, time: Date) {
        let dateComponents = self.dateComponents([.year, .month, .day], from: date)
        let timeComponents = self.dateComponents([.hour, .minute], from: date)
        
        let dateOnly = self.date(from: dateComponents) ?? Date()
        let timeOnly = self.date(from: timeComponents) ?? Date()
        
        return (date: dateOnly, time: timeOnly)
    }
}
