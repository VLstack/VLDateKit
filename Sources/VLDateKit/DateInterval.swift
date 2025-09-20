import Foundation

extension DateInterval
{
 // MARK: - Private API
 @frozen
 public enum OffsetDirection
 {
  case forward
  case backward
 }

 // MARK: Public API
 /// Returns the calendar component that defines this interval, if any.
 /// For example, an interval representing a whole month returns `.month`.
 /// - Parameter calendar: The calendar to use (default is `.current`).
 /// - Returns: The matching calendar component, or `nil` if none is found.
 public func calendarComponent(calendar: Calendar = .current) -> Calendar.Component?
 {
  let components: [ Calendar.Component ] = [ .year, .month, .weekOfYear, .day, .hour, .minute, .second ]

  return components.first { calendar.dateInterval(of: $0, for: self.start) == self }
 }

 /// Returns the next interval of the same calendar component as this one.
 /// If no component can be determined, falls back to offsetting by the same length.
 /// - Parameter calendar: The calendar to use (default is `.current`).
 /// - Returns: The next `DateInterval`, or an offset interval if no component was found.
 public func nextInterval(calendar: Calendar = .current) -> DateInterval?
 {
  guard let component = self.calendarComponent(calendar: calendar)
  else { return self.offsetBySameLength(.forward) }

  return calendar.dateInterval(of: component, for: self.end)
 }

 /// Returns a new interval of the same duration, offset either forward or backward in time.
 /// - Parameter direction: Pass `.forward` to move forward, `.backward` to move backward.
 /// - Returns: A `DateInterval` with the same length as the current one, shifted in time.
 public func offsetBySameLength(_ direction: DateInterval.OffsetDirection) -> DateInterval
 {
  let start: Date
  let end: Date

  switch direction
  {
   case .forward:
    start = self.end
    end = start.addingTimeInterval(self.duration)

   case .backward:
    end = self.start
    start = end.addingTimeInterval(-self.duration)
  }

  return DateInterval(start: start, end: end)
 }

 /// Returns the previous interval of the same calendar component as this one.
 /// If no component can be determined, falls back to offsetting by the same length.
 /// - Parameter calendar: The calendar to use (default is `.current`).
 /// - Returns: The previous `DateInterval`, or an offset interval if no component was found.
 public func previousInterval(calendar: Calendar = .current) -> DateInterval?
 {
  guard let component = self.calendarComponent(calendar: calendar),
        let previousStart = calendar.date(byAdding: component, value: -1, to: self.start)
  else { return self.offsetBySameLength(.backward) }

  return calendar.dateInterval(of: component, for: previousStart)
 }

 // MARK: - Deprecated API
 @available(*, deprecated, renamed: "calendarComponent(calendar:)")
 public func calendarComponent(using calendar: Calendar) -> Calendar.Component?
 {
  calendarComponent(calendar: calendar)
 }

 @available(*, deprecated, renamed: "nextInterval(calendar:)")
 public func nextInterval(using calendar: Calendar) -> DateInterval?
 {
  nextInterval(calendar: calendar)
 }

 @available(*, deprecated, renamed: "offsetBySameLength(_:)")
 public func offsetBySameLength(forward: Bool) -> DateInterval
 {
  offsetBySameLength(forward ? .forward : .backward)
 }

 @available(*, deprecated, renamed: "previousInterval(calendar:)")
 public func previousInterval(using calendar: Calendar) -> DateInterval?
 {
  previousInterval(calendar: calendar)
 }
}
