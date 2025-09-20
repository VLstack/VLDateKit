import Foundation

extension Date
{
 // MARK: - Private API

 /// Returns the given interval if non-nil, otherwise falls back to a zero-length interval at the current time.
 /// - Parameter interval: The optional `DateInterval`.
 /// - Returns: The provided interval or a fallback interval starting and ending at `.now`.
 private static func _safe(interval: DateInterval?) -> DateInterval
 {
  interval ?? DateInterval(start: .now, end: .now)
 }

 // MARK: - Public API

 /// The first day of the week according to the current calendar.
 public static let firstDayOfWeek = Calendar.current.firstWeekday

 /// The full localized names of all months (January–December) according to the current locale.
 /// - Returns: An array of 12 month names.
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
  }
 }

 // TODO: create a func to convert everything, or maybe use Measurement
 /// The number of seconds in a standard day (24 hours).
 public static let secondsInDay: TimeInterval = 24 * 60 * 60

 /// The interval covering the current month, or a fallback to `.now` if unavailable.
 public static var thisMonthInterval: DateInterval { _safe(interval: Date.now.currentMonthInterval) }

 /// The interval covering the current week, or a fallback to `.now` if unavailable.
 public static var thisWeekInterval: DateInterval { _safe(interval: Date.now.currentWeekInterval) }

 /// The interval covering the current year, or a fallback to `.now` if unavailable.
 public static var thisYearInterval: DateInterval { _safe(interval: Date.now.currentYearInterval) }

 /// The interval covering the current day, or a fallback to `.now` if unavailable.
 public static var todayInterval: DateInterval { _safe(interval: Date.now.currentDayInterval) }

 /// The localized short names of the weekdays, ordered according to the current calendar’s first weekday.
 /// - Returns: An array of 7 weekday symbols.
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

 /// The interval covering the previous day, or a fallback to `.now` if unavailable.
 public static var yesterdayInterval: DateInterval { _safe(interval: Date.now.previousDayInterval) }
}
