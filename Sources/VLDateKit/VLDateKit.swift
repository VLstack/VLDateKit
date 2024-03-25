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
 
 var endOfDay: Date?
 {
  let calendar = Calendar.current
  let selfComponents = calendar.dateComponents([.year, .month, .day], from: self)
  var components = selfComponents
  components.hour = 23
  components.minute = 59
  components.second = 59

  return calendar.date(from: components)
 }
 
 var endOfMonth: Date
 {
  // Unfortunatly this lastDay is in fact the nextDay of the month at midnight
  guard let lastDay: Date = Calendar.current.dateInterval(of: .month, for: self)?.end
  else { return .distantFuture }
  
  guard let day = Calendar.current.date(byAdding: .day, value: -1, to: lastDay)
  else { return .distantFuture }
  
  return day
 }

 func isSame(_ date: Date?,
             toGranularity: Calendar.Component = .day) -> Bool
 {
  guard let date
  else { return false }
  
  return Calendar.current.isDate(self, equalTo: date, toGranularity: toGranularity)
 }
 
 // TODO: create a func "duration" with parameters to define granularity
 func minutesDuration(to date: Date) -> Int?
 {
  let calendar = Calendar.current

  let componentsEnd = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
  guard let dateEnd = calendar.date(from: componentsEnd)
  else { return nil }

  let componentsSelf = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
  guard let dateSelf = calendar.date(from: componentsSelf)
  else { return nil }

  let components = calendar.dateComponents([.hour, .minute], from: dateSelf, to: dateEnd)

  if let hours = components.hour,
     let minutes = components.minute
  {
   return hours * 60 + minutes
  }

  return nil
 }
 
 var startOfDay: Date?
 {
  let calendar = Calendar.current
  let selfComponents = calendar.dateComponents([.year, .month, .day], from: self)
  var components = selfComponents
  components.hour = 0
  components.minute = 0
  components.second = 0

  return calendar.date(from: components)
 }
 
 var startOfMonth: Date
 {
  guard let day = Calendar.current.dateInterval(of: .month, for: self)?.start
  else { return .distantPast }
  
  return day
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
  if let now = calendar.date(from: components),
     let yesterday = calendar.date(byAdding: .day, value: -1, to: now)
  {
   return yesterday
  }
  
  return nil
 }
}
