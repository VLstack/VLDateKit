import Foundation

extension DateInterval
{
 public func calendarComponent(using calendar: Calendar = .current) -> Calendar.Component?
 {
  let components: [ Calendar.Component ] = [ .year, .month, .weekOfYear, .day, .hour, .minute, .second ]

  return components.first { calendar.dateInterval(of: $0, for: self.start) == self }
 }

 public func offsetBySameLength(forward: Bool) -> DateInterval
 {
  let newStart: Date
  let newEnd: Date

  if forward
  {
   newStart = self.end
   newEnd = newStart.addingTimeInterval(self.duration)
  }
  else
  {
   newEnd = self.start
   newStart = newEnd.addingTimeInterval(-self.duration)
  }

  return DateInterval(start: newStart, end: newEnd)
 }

 public func nextInterval(using calendar: Calendar = .current) -> DateInterval?
 {
  guard let component = self.calendarComponent(using: calendar)
  else { return self.offsetBySameLength(forward: true) }

  return calendar.dateInterval(of: component, for: self.end)
 }

 public func previousInterval(using calendar: Calendar = .current) -> DateInterval?
 {
  guard let component = self.calendarComponent(using: calendar),
        let previousStart = calendar.date(byAdding: component, value: -1, to: self.start)
  else { return self.offsetBySameLength(forward: false) }

  return calendar.dateInterval(of: component, for: previousStart)
 }
}
