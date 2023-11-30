//
//  Date+.swift
//  ToDoListApp
//
//  Created by 이대현 on 11/30/23.
//

import Foundation

extension Date {
    var isToday: Bool {
        get {
            // 다음날 자정보다 이른 시간이면 today
            let calendar = Calendar.current
            let tomorrow = calendar.date(byAdding: .day,value: 1, to: Date())!
            let tomorrowMidnight = calendar.startOfDay(for: tomorrow)
            return self.compare(tomorrowMidnight) == .orderedAscending
        }
    }
    
    var tomorrow: Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: 1, to: self)!
    }
    
    var endOfDay: Date {
        // 해당 날의 23시 59분을 반환
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: self)!
        let tomorrowMidnight = calendar.startOfDay(for: tomorrow)
        return calendar.date(byAdding: .minute, value: -1, to: tomorrowMidnight)!
    }
    
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
