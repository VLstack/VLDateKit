import Foundation

extension Date
{
 // MARK: - Private API

 /// Computes the number of full days between two dates, ignoring the time component.
 /// Returns `0` if `start >= end`.
 /// - Parameters:
 ///   - start: The start date.
 ///   - end: The end date.
 ///   - calendar: The calendar to use for normalization and calculation.
 /// - Returns: The number of whole days between `start` and `end`.
 @usableFromInline
 internal func _countDaysBetween(_ start: Date,
                                 _ end: Date,
                                 calendar: Calendar) -> Int
 {
  let startDate = calendar.startOfDay(for: start)
  let endDate = calendar.startOfDay(for: end)
  guard startDate < endDate else { return 0 }

  return calendar.dateComponents([ .day ], from: startDate, to: endDate).day ?? 0
 }

 // MARK: - Public API

 /// Adds a value to a calendar component of the date.
 /// - Parameters:
 ///   - component: The calendar component to add to (default is .day).
 ///   - value: The value to add (can be negative to subtract).
 ///   - calendar: The calendar to use (default is .current).
 /// - Returns: The resulting date after adding the value to the component.
 @inlinable
 public func adding(_ component: Calendar.Component = .day,
                    value: Int,
                    calendar: Calendar = .current) -> Date
 {
  calendar.date(byAdding: component, value: value, to: self) ?? self
 }

 /// Returns the number of days from the current date to the specified date.
 /// If the other date is earlier than the current date, the result is `0`.
 /// - Parameters:
 ///   - to: The end date to count to.
 ///   - calendar: The calendar to use (defaults to `.current`).
 /// - Returns: The number of whole days between the two dates.
 @inlinable
 public func countDays(to other: Date,
                       calendar: Calendar = .current) -> Int
 {
  self._countDaysBetween(self, other, calendar: calendar)
 }

 /// Returns the number of days from the specified date to the current date.
 /// If the current date is earlier than the other date, the result is `0`.
 /// - Parameters:
 ///   - from: The start date to count from.
 ///   - calendar: The calendar to use (defaults to `.current`).
 /// - Returns: The number of whole days between the two dates.
 @inlinable
 public func countDays(from other: Date,
                       calendar: Calendar = .current) -> Int
 {
  self._countDaysBetween(other, self, calendar: calendar)
 }

 /// Returns the DateInterval for the current day.
 /// - Parameter calendar: The calendar to use (default is .current).
 /// - Returns: The DateInterval representing the current day.
 public func currentDayInterval(calendar: Calendar = .current) -> DateInterval?
 {
  calendar.dateInterval(of: .day, for: self)
 }

 /// Returns the DateInterval for the current month.
 /// - Parameter calendar: The calendar to use (default is .current).
 /// - Returns: The DateInterval representing the current month.
 public func currentMonthInterval(calendar: Calendar = .current) -> DateInterval?
 {
  calendar.dateInterval(of: .month, for: self)
 }

 /// Returns the DateInterval for the current week.
 /// - Parameter calendar: The calendar to use (default is .current).
 /// - Returns: The DateInterval representing the current week.
 public func currentWeekInterval(calendar: Calendar = .current) -> DateInterval?
 {
  calendar.dateInterval(of: .weekOfYear, for: self)
 }

 /// Returns the DateInterval for the current year.
 /// - Parameter calendar: The calendar to use (default is .current).
 /// - Returns: The DateInterval representing the current year.
 public func currentYearInterval(calendar: Calendar = .current) -> DateInterval?
 {
  calendar.dateInterval(of: .year, for: self)
 }

 /// Returns the day component of the date in the current calendar.
 @inlinable
 public var dayNumber: Int { self.dayNumber(calendar: .current) }

 /// Returns the day component of the date using the specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: The day number of the date.
 @inlinable
 public func dayNumber(calendar: Calendar) -> Int
 {
  calendar.component(.day, from: self)
 }

 /// Returns the duration between the current date and another date as DateComponents.
 /// - Parameters:
 ///   - to: The other date.
 ///   - components: The set of calendar components to calculate (default: hour, minute, second).
 ///   - calendar: The calendar to use (default: .current).
 /// - Returns: The DateComponents representing the duration between the two dates.
 @inlinable
 public func duration(to date: Date,
                      components: Set<Calendar.Component> = [ .hour, .minute, .second ],
                      calendar: Calendar = .current) -> DateComponents
 {
  let fromDate: Date = min(date, self)
  let toDate: Date = max(date, self)

  return calendar.dateComponents(components, from: fromDate, to: toDate)
 }

 /// Returns the start of the next day, effectively representing the end of the current day using the current calendar.
 @inlinable
 public var endOfDay: Date { self.endOfDay(calendar: .current) }

 /// Returns the start of the next day, effectively representing the end of the current day.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: A Date corresponding to midnight of the following day.
 @inlinable
 public func endOfDay(calendar: Calendar) -> Date
 {
  calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: self) ?? self)
 }

 /// Returns the end of the month for the current date using the current calendar.
 /// Note: The returned date is the start of the next month.
 @inlinable
 public var endOfMonth: Date { self.endOfMonth(calendar: .current) }

 /// Returns the end of the month for the current date using a specified calendar.
 /// Note: The returned date is the start of the next month.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: A Date representing the end of the current month.
 @inlinable
 public func endOfMonth(calendar: Calendar) -> Date
 {
  calendar.dateInterval(of: .month, for: self)?.end ?? self
 }

 /// Returns the date of the first weekday before the start of the current month in the current calendar.
 public var firstWeekdayBeforeStartOfMonth: Date { self.firstWeekdayBeforeStartOfMonth(calendar: .current) }

 /// Returns the date of the first weekday before the start of the current month.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: The Date of the first weekday before the start of the month.
 public func firstWeekdayBeforeStartOfMonth(calendar: Calendar) -> Date
 {
  let startOfMonthWeekday = calendar.component(.weekday, from: startOfMonth)
  let numberFromPreviousMonth = startOfMonthWeekday - Self.firstDayOfWeek

  return startOfMonth.reducing(.day, value: numberFromPreviousMonth)
 }

 /// Checks if the date is between two dates, inclusive.
 /// - Parameters:
 ///   - startDate: The start date.
 ///   - endDate: The end date.
 /// - Returns: True if the date is between startDate and endDate (inclusive), false otherwise.
 @inlinable
 public func isBetween(_ startDate: Date,
                       to endDate: Date) -> Bool
 {
  (startDate...endDate).contains(self)
 }

 /// Checks if the date is between two dates, excluding the end date.
 /// - Parameters:
 ///   - startDate: The start date.
 ///   - endDate: The end date.
 /// - Returns: True if the date is between startDate and endDate (exclusive), false otherwise.
 @inlinable
 public func isBetween(_ startDate: Date,
                       until endDate: Date) -> Bool
 {
  (startDate..<endDate).contains(self)
 }

 /// Returns true if the date is in the future relative to now.
 @inlinable
 public var isFuture: Bool { self.isFuture(relativeTo: Date()) }

 /// Returns true if the date is in the future relative to the specified date.
 /// - Parameter date: The reference date (default is now).
 /// - Returns: True if the date is later than the reference date.
 @inlinable
 public func isFuture(relativeTo date: Date = Date()) -> Bool { self > date }

 /// Returns true if the date is in the past relative to now.
 @inlinable
 public var isPast: Bool { self.isPast(relativeTo: Date()) }

 /// Returns true if the date is in the past relative to the specified date.
 /// - Parameter date: The reference date (default is now).
 /// - Returns: True if the date is earlier than the reference date.
 @inlinable
 public func isPast(relativeTo date: Date) -> Bool { self < date }

 /// Checks if the current date is the same as another date to the specified granularity.
 /// - Parameters:
 ///   - date: The date to compare (optional).
 ///   - toGranularity: The granularity to compare (default: .day).
 ///   - calendar: The calendar to use (default: .current).
 /// - Returns: True if the dates are equal to the specified granularity.
 @inlinable
 public func isSame(_ date: Date?,
                    toGranularity: Calendar.Component = .day,
                    calendar: Calendar = .current) -> Bool
 {
  guard let date else { return false }

  return calendar.isDate(self, equalTo: date, toGranularity: toGranularity)
 }

 /// Returns the month component of the date in the current calendar.
 @inlinable
 public var monthNumber: Int { self.monthNumber(calendar: .current) }

 /// Returns the month component of the date using the specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: The month number of the date.
 @inlinable
 public func monthNumber(calendar: Calendar) -> Int
 {
  calendar.component(.month, from: self)
 }

 /// Returns the number of days in the month of the date in the current calendar.
 @inlinable
 public var numberOfDaysInMonth: Int { self.numberOfDaysInMonth(calendar: .current) }

 /// Returns the number of days in the month of the date using the specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: The number of days in the month.
 @inlinable
 public func numberOfDaysInMonth(calendar: Calendar) -> Int
 {
  calendar.component(.day, from: endOfMonth)
 }

 /// Returns the total number of weeks in the month of the date (complete + incomplete).
 public var numberOfWeeksInMonth: Int
 {
  self.numberOfCompleteWeeksInMonth + self.numberOfIncompleteWeeksInMonth
 }

 /// Returns the total number of weeks in the month of the date using the specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: The number of weeks in the month.
 public func numberOfWeeksInMonth(calendar: Calendar) -> Int
 {
  self.numberOfCompleteWeeksInMonth(calendar: calendar) + self.numberOfIncompleteWeeksInMonth(calendar: calendar)
 }

 /// Returns the number of complete weeks in the month of the date in the current calendar.
 public var numberOfCompleteWeeksInMonth: Int { self.numberOfCompleteWeeksInMonth(calendar: .current) }

 /// Returns the number of complete weeks in the month of the date using the specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: The number of complete weeks.
 public func numberOfCompleteWeeksInMonth(calendar: Calendar) -> Int
 {
  guard let interval = calendar.dateInterval(of: .month, for: self)
  else { return 0 }

  let firstDayOfMonth = interval.start
  let lastDayOfMonth = interval.end
  let components = calendar.dateComponents([.weekOfMonth], from: firstDayOfMonth, to: lastDayOfMonth)

  return components.weekOfMonth ?? 0
 }

 /// Returns the number of incomplete weeks in the month of the date in the current calendar.
 public var numberOfIncompleteWeeksInMonth: Int { self.numberOfIncompleteWeeksInMonth(calendar: .current) }

 /// Returns the number of incomplete weeks in the month of the date using the specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: 1 if the last week is incomplete, otherwise 0.
 public func numberOfIncompleteWeeksInMonth(calendar: Calendar) -> Int
 {
  guard let lastDayOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: self),
        let weekRange = calendar.range(of: .weekOfMonth, in: .month, for: lastDayOfMonth)
  else { return 0 }

  return weekRange.count < 7 ? 1 : 0
 }

 /// Returns the DateInterval for the previous day relative to the current date.
 /// - Parameter calendar: The calendar to use (default is .current).
 /// - Returns: The DateInterval representing the previous day, or nil if calculation fails.
 public func previousDayInterval(calendar: Calendar = .current) -> DateInterval?
 {
  guard let day = calendar.date(byAdding: .day, value: -1, to: self)
  else { return nil }

  return calendar.dateInterval(of: .day, for: day)
 }

 /// Reduces a calendar component of the date by the specified value.
 /// - Parameters:
 ///   - component: The calendar component to reduce (default is .day).
 ///   - value: The value to subtract.
 ///   - calendar: The calendar to use (default is .current).
 /// - Returns: The resulting date after reduction.
 @inlinable
 public func reducing(_ component: Calendar.Component = .day,
                      value: Int,
                      calendar: Calendar = .current) -> Date
 {
  adding(component,
         value: -value,
         calendar: calendar)
 }

 /// Returns the start of the day for the current date using the current calendar.
 @inlinable
 public var startOfDay: Date { self.startOfDay(calendar: .current) }

 /// Returns the start of the day (midnight) for the current date using the specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: A Date representing midnight at the start of the day.
 @inlinable
 public func startOfDay(calendar: Calendar) -> Date
 {
  calendar.startOfDay(for: self)
 }

 /// Returns the start of the month for the current date using the current calendar.
 @inlinable
 public var startOfMonth: Date { self.startOfMonth(calendar: .current) }

 /// Returns the start of the month for the current date using a specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: A `Date` representing the first day of the month.
 @inlinable
 public func startOfMonth(calendar: Calendar) -> Date
 {
  calendar.dateInterval(of: .month, for: self)?.start ?? self
 }

 /// Returns the start of the previous month relative to the current date.
 @inlinable
 public var startOfPreviousMonth: Date { self.startOfPreviousMonth(calendar: .current) }

 /// Returns the start of the previous month relative to the current date using the specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: A Date representing the first day of the previous month.
 @inlinable
 public func startOfPreviousMonth(calendar: Calendar) -> Date
 {
  reducing(.month,
           value: 1,
           calendar: calendar).startOfMonth
 }

 /// Returns the year component of the date in the current calendar.
 @inlinable
 public var yearNumber: Int { self.yearNumber(calendar: .current) }

 /// Returns the year component of the date using the specified calendar.
 /// - Parameter calendar: The calendar to use.
 /// - Returns: The year number of the date.
 @inlinable
 public func yearNumber(calendar: Calendar) -> Int
 {
  calendar.component(.year, from: self)
 }

 /// Returns the date for yesterday relative to the current date.
 public var yesterday: Date? { self.yesterday(toGranularity: .day, calendar: .current) }

 /// Returns the date for yesterday relative to the current date, adjusted to a specified granularity.
 /// - Parameters:
 ///   - toGranularity: The calendar component granularity to preserve (default is .day).
 ///   - calendar: The calendar to use (default is .current).
 /// - Returns: The Date representing yesterday, or nil if calculation fails.
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

 // MARK: - Deprecated API
 
 @available(*, deprecated, renamed: "currentDayInterval(calendar:)")
 public func currentDayInterval(using calendar: Calendar = .current) -> DateInterval?
 {
  currentDayInterval(calendar: calendar)
 }

 @available(*, deprecated, renamed: "currentMonthInterval(calendar:)")
 public func currentMonthInterval(using calendar: Calendar = .current) -> DateInterval?
 {
  currentMonthInterval(calendar: calendar)
 }

 @available(*, deprecated, renamed: "currentWeekInterval(calendar:)")
 public func currentWeekInterval(using calendar: Calendar = .current) -> DateInterval?
 {
  currentWeekInterval(calendar: calendar)
 }

 @available(*, deprecated, renamed: "currentYearInterval(calendar:)")
 public func currentYearInterval(using calendar: Calendar = .current) -> DateInterval?
 {
  currentYearInterval(calendar: calendar)
 }

 @available(*, deprecated, renamed: "duration(to:components:calendar:)", message: "use .duration(to: date, components: [ .minute ]) instead")
 public func minutesDuration(to date: Date) -> Int?
 {
  duration(to: date, components: [ .minute ]).minute
 }

 @available(*, deprecated, renamed: "previousDayInterval(calendar:)")
 public func previousDayInterval(using calendar: Calendar = .current) -> DateInterval?
 {
  previousDayInterval(calendar: calendar)
 }
}
