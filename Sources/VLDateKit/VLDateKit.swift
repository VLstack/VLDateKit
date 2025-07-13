import Foundation

extension Date
{
 public func adding(_ component: Calendar.Component = .day,
                    value: Int,
                    calendar: Calendar = .current) -> Date
 {
  calendar.date(byAdding: component, value: value, to: self) ?? self
 }

 /// Computes the number of full days between two dates, ignoring the time component.
 /// Returns `0` if `start >= end`.
 /// - Parameters:
 ///   - start: The start date.
 ///   - end: The end date.
 ///   - calendar: The calendar to use for normalization and calculation.
 /// - Returns: The number of whole days between `start` and `end`.
 private func _countDaysBetween(_ start: Date,
                                _ end: Date,
                                calendar: Calendar) -> Int
 {
  let startDate = calendar.startOfDay(for: start)
  let endDate = calendar.startOfDay(for: end)
  guard startDate < endDate else { return 0 }

  return calendar.dateComponents([ .day ], from: startDate, to: endDate).day ?? 0
 }

 /// Returns the number of days from the current date to the specified date.
 /// If the other date is earlier than the current date, the result is `0`.
 /// - Parameters:
 ///   - other: The end date to count to.
 ///   - calendar: The calendar to use (defaults to `.current`).
 /// - Returns: The number of whole days between the two dates.
 public func countDays(to other: Date,
                       calendar: Calendar = .current) -> Int
 {
  self._countDaysBetween(self, other, calendar: calendar)
 }

 /// Returns the number of days from the specified date to the current date.
 /// If the current date is earlier than the other date, the result is `0`.
 /// - Parameters:
 ///   - other: The start date to count from.
 ///   - calendar: The calendar to use (defaults to `.current`).
 /// - Returns: The number of whole days between the two dates.
 public func countDays(from other: Date,
                       calendar: Calendar = .current) -> Int
 {
  self._countDaysBetween(other, self, calendar: calendar)
 }

 public var dayNumber: Int { self.dayNumber(calendar: .current) }

 public func dayNumber(calendar: Calendar) -> Int
 {
  calendar.component(.day, from: self)
 }

 public func duration(to date: Date,
                      components: Set<Calendar.Component> = [ .hour, .minute, .second ],
                      calendar: Calendar = .current) -> DateComponents
 {
  let fromDate: Date = min(date, self)
  let toDate: Date = max(date, self)

  return calendar.dateComponents(components, from: fromDate, to: toDate)
 }

 /// Returns the start of the next day, effectively representing the end of the current day using the current calendar.
 public var endOfDay: Date { self.endOfDay(calendar: .current) }

 /// Returns the start of the next day, effectively representing the end of the current day.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: A `Date` corresponding to midnight of the following day.
 public func endOfDay(calendar: Calendar) -> Date
 {
  calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: self) ?? self)
 }

 /// Returns the end of the month for the current date using the current calendar.
 /// Note: The returned date is the start of the next month.
 public var endOfMonth: Date { self.endOfMonth(calendar: .current) }

 /// Returns the end of the month for the current date using a specified calendar.
 /// Note: The returned date is the start of the next month.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: A `Date` representing the end of the current month.
 public func endOfMonth(calendar: Calendar) -> Date
 {
  calendar.dateInterval(of: .month, for: self)?.end ?? self
 }

 public var firstWeekdayBeforeStartOfMonth: Date { self.firstWeekdayBeforeStartOfMonth(calendar: .current) }

 public func firstWeekdayBeforeStartOfMonth(calendar: Calendar) -> Date
 {
  let startOfMonthWeekday = calendar.component(.weekday, from: startOfMonth)
  let numberFromPreviousMonth = startOfMonthWeekday - Self.firstDayOfWeek

  return startOfMonth.reducing(.day, value: numberFromPreviousMonth)
 }

 public func isBetween(_ startDate: Date,
                       to endDate: Date) -> Bool
 {
  (startDate...endDate).contains(self)
 }

 public func isBetween(_ startDate: Date,
                       until endDate: Date) -> Bool
 {
  (startDate..<endDate).contains(self)
 }

 public var isPast: Bool { self.isPast(relativeTo: Date()) }
 public func isPast(relativeTo date: Date) -> Bool { self < date }

 public var isFuture: Bool { self.isFuture(relativeTo: Date()) }
 public func isFuture(relativeTo date: Date = Date()) -> Bool { self > date }

 public func isSame(_ date: Date?,
                    toGranularity: Calendar.Component = .day,
                    calendar: Calendar = .current) -> Bool
 {
  guard let date else { return false }

  return calendar.isDate(self, equalTo: date, toGranularity: toGranularity)
 }
 
 // TODO: create a func "duration" with parameters to define granularity
 // TODO: create also a version with "from" parameter
 @available(*, deprecated, renamed: "duration", message: "use .duration(to: date, components: [ .minute ]) instead")
 func minutesDuration(to date: Date) -> Int?
 {
  duration(to: date, components: [ .minute ]).minute
 }
 
 public var monthNumber: Int { self.monthNumber(calendar: .current) }

 public func monthNumber(calendar: Calendar) -> Int
 {
  calendar.component(.month, from: self)
 }

 public var numberOfDaysInMonth: Int { self.numberOfDaysInMonth(calendar: .current) }

 public func numberOfDaysInMonth(calendar: Calendar) -> Int
 {
  calendar.component(.day, from: endOfMonth)
 }

 public var numberOfWeeksInMonth: Int
 {
  self.numberOfCompleteWeeksInMonth + self.numberOfIncompleteWeeksInMonth
 }

 public func numberOfWeeksInMonth(calendar: Calendar) -> Int
 {
  self.numberOfCompleteWeeksInMonth(calendar: calendar) + self.numberOfIncompleteWeeksInMonth(calendar: calendar)
 }

 public var numberOfCompleteWeeksInMonth: Int { self.numberOfCompleteWeeksInMonth(calendar: .current) }

 public func numberOfCompleteWeeksInMonth(calendar: Calendar) -> Int
 {
  let interval = calendar.dateInterval(of: .month, for: self)!
  let firstDayOfMonth = interval.start
  let lastDayOfMonth = interval.end
  let components = calendar.dateComponents([.weekOfMonth], from: firstDayOfMonth, to: lastDayOfMonth)

  return components.weekOfMonth ?? 0
 }

 public var numberOfIncompleteWeeksInMonth: Int { self.numberOfIncompleteWeeksInMonth(calendar: .current) }

 public func numberOfIncompleteWeeksInMonth(calendar: Calendar) -> Int
 {
  let lastDayOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: self)!

  return calendar.range(of: .weekOfMonth, in: .month, for: lastDayOfMonth)!.count < 7 ? 1 : 0
 }

 public func reducing(_ component: Calendar.Component = .day,
                      value: Int,
                      calendar: Calendar = .current) -> Date
 {
  adding(component,
         value: -value,
         calendar: calendar)
 }
 
 /// Returns the start of the day for the current date using the current calendar.
 public var startOfDay: Date { self.startOfDay(calendar: .current) }

 /// Returns the start of the day for the current date using a specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: A `Date` representing midnight at the start of the day.
 public func startOfDay(calendar: Calendar) -> Date
 {
  calendar.startOfDay(for: self)
 }

 /// Returns the start of the month for the current date using the current calendar.
 public var startOfMonth: Date { self.startOfMonth(calendar: .current) }

 /// Returns the start of the month for the current date using a specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: A `Date` representing the first day of the month.
 public func startOfMonth(calendar: Calendar) -> Date
 {
  calendar.dateInterval(of: .month, for: self)?.start ?? self
 }

 public var startOfPreviousMonth: Date { self.startOfPreviousMonth(calendar: .current) }

 public func startOfPreviousMonth(calendar: Calendar) -> Date
 {
  reducing(.month,
           value: 1,
           calendar: calendar).startOfMonth
 }

 public var yearNumber: Int { self.yearNumber(calendar: .current) }

 public func yearNumber(calendar: Calendar) -> Int
 {
  calendar.component(.year, from: self)
 }

 public var yesterday: Date? { self.yesterday(toGranularity: .day, calendar: .current) }
 public func yesterday(toGranularity: Calendar.Component = .day,
                       calendar: Calendar = .current) -> Date?
 {
  let map: [ Calendar.Component: Set<Calendar.Component> ] = [
   .day: [.year, .month, .day],
   .hour: [ .year, .month, .day, .hour ],
   .minute: [ .year, .month, .day, .hour, .minute ],
   .second: [ .year, .month, .day, .hour, .minute, .second ],
   .nanosecond: [ .year, .month, .day, .hour, .minute, .second, .nanosecond ]
  ]
  let components: DateComponents = calendar.dateComponents(map[toGranularity] ?? [ .year, .month, .day ], from: self)

  return calendar.date(from: components)?.reducing(.day, value: 1)
 }
}
