import Foundation

public extension Date
{
 @available(*, deprecated, message: "Define your own Date.init format in your project")
 init(fr dateString: String)
 {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
  if let date = dateFormatter.date(from: dateString)
  {
   self = date
  }
  else
  {
   self = Date.now
  }
 }

 func adding(days: Int) -> Date
 {
  Calendar.current.date(byAdding: .day, value: days, to: self)!
 }
 
 var dayNumber: Int
 {
  Calendar.current.component(.day, from: self)
 }
 
 func duration(to date: Date,
               components: Set<Calendar.Component> = [ .hour, .minute, .second ]) -> DateComponents
 {
  let fromDate: Date = min(date, self)
  let toDate: Date = max(date, self)

  return Calendar.current.dateComponents(components, from: fromDate, to: toDate)
 }

 var endOfDay: Date
 {
  Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
 }
 
 var endOfMonth: Date
 {
  // Unfortunatly this lastDay is in fact the nextDay of the month at midnight
  guard let lastDay: Date = Calendar.current.dateInterval(of: .month, for: self)?.end
  else { return .distantFuture }
  
  return lastDay.reducingDays(1)
 }
 
 var firstWeekdayBeforeStartOfMonth: Date
 {
  let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
  let numberFromPreviousMonth = startOfMonthWeekday - Self.firstDayOfWeek
  
  return startOfMonth.reducingDays(numberFromPreviousMonth)
 }
 
 func isBetween(_ startDate: Date,
                to endDate: Date) -> Bool
 {
  (startDate...endDate).contains(self)
 }

 func isBetween(_ startDate: Date,
                until endDate: Date) -> Bool
 {
  (startDate..<endDate).contains(self)
 }
 
 func isPast() -> Bool { self < Date() }

 func isFuture() -> Bool { self > Date() }

 func isSame(_ date: Date?,
             toGranularity: Calendar.Component = .day) -> Bool
 {
  guard let date
  else { return false }
  
  return Calendar.current.isDate(self, equalTo: date, toGranularity: toGranularity)
 }
 
 // TODO: create a func "duration" with parameters to define granularity
 // TODO: create also a version with "from" parameter
 @available(*, deprecated, renamed: "duration", message: "use .duration(to: date, components: [ .minute ]) instead")
 func minutesDuration(to date: Date) -> Int?
 {
  duration(to: date, components: [ .minute ]).minute
 }
 
 var monthNumber: Int
 {
  Calendar.current.component(.month, from: self)
 }
 
 var numberOfDaysInMonth: Int
 {
  Calendar.current.component(.day, from: endOfMonth)
 }

 func reducingDays(_ days: Int) -> Date
 {
  addingDays(-days)
 }

 var startOfDay: Date
 {
  Calendar.current.startOfDay(for: self)
 }
 
 var startOfMonth: Date
 {
  guard let day = Calendar.current.dateInterval(of: .month, for: self)?.start
  else { return .distantPast }
  
  return day
 }
 
 var startOfPreviousMonth: Date
 {
  reducingDays(1).startOfMonth
 }
 
// var sundayBeforeStartOfMonth: Date
// {
//  let startOfMonthWeekday: Int = Calendar.current.component(.weekday, from: startOfMonth)
//  let numberFromPreviousMonth: Int = startOfMonthWeekday - 1
//  
//  return startOfMonth.reducingDays(numberFromPreviousMonth)
// }

 var yearNumber: Int
 {
  Calendar.current.component(.year, from: self)
 }

 func yesterday(toGranularity: Calendar.Component = .day) -> Date?
 {
  let calendar = Calendar.current
  let map: [Calendar.Component: Set<Calendar.Component>] = [
   .day: [.year, .month, .day],
   .hour: [ .year, .month, .day, .hour ],
   .minute: [ .year, .month, .day, .hour, .minute ],
   .second: [ .year, .month, .day, .hour, .minute, .second ],
   .nanosecond: [ .year, .month, .day, .hour, .minute, .second, .nanosecond ]
  ]
  let components: DateComponents = calendar.dateComponents(map[toGranularity] ?? [ .year, .month, .day ], from: self)

  return calendar.date(from: components)?.reducingDays(1)
 }
}
