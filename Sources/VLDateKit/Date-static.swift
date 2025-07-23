import Foundation

extension Date
{
 public static let firstDayOfWeek = Calendar.current.firstWeekday

 public static var fullMonthNames: [ String ]
 {
  let formatter = DateFormatter()
  formatter.locale = Locale.current
  formatter.setLocalizedDateFormatFromTemplate("MMMM")

  return (1...12).compactMap
  {
   month in
   guard let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
   else { return "?" }

   return formatter.string(from: date)
   //   return date.map { formatter.string(from: $0) }
  }
 }

 // TODO: create a func to convert everything, or maybe use Measurement
 public static let secondsInDay: TimeInterval = 24 * 60 * 60

 public static var thisMonthInterval: DateInterval { Date.now.currentMonthInterval()! }

 public static var thisWeekInterval: DateInterval { Date.now.currentWeekInterval()! }

 public static var thisYearInterval: DateInterval { Date.now.currentYearInterval()! }

 public static var todayInterval: DateInterval { Date.now.currentDayInterval()! }

 public static var weekdays: [ String ]
 {
  let calendar = Calendar.current
  var weekdays = calendar.shortWeekdaySymbols
  if firstDayOfWeek > 1
  {
   for _ in 1..<firstDayOfWeek
   {
    if let first = weekdays.first
    {
     weekdays.append(first)
     weekdays.removeFirst()
    }
   }
  }

  return weekdays
 }

 public static var yesterdayInterval: DateInterval { Date.now.previousDayInterval()! }
}
