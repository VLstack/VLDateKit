import VLstackNamespace
import Foundation

extension VLstack
{
 /// A unique identifier for a date, based on year-month-day.
 /// Useful to identify elements (like DTOs) even if multiple items share the same day.
 public struct DateKey: Identifiable, Hashable, Sendable
 {
  /// The string identifier of the date, formatted as "YYYY-MM-DD" or a fallback for invalid dates.
  public let id: String
  /// The year component of the date.
  public let year: Int
  /// The month component of the date.
  public let month: Int
  /// The day component of the date.
  public let day: Int

  /// Initializes a `DateKey` from a `Date` using the provided calendar
  /// - Parameters:
  ///   - date: The date to extract components from.
  ///   - calendar: The calendar to use (default is `.current`).
  public init(_ date: Date,
              calendar: Calendar = .current)
  {
   let components = calendar.dateComponents([ .year, .month, .day ], from: date)
   self.year = components.year ?? 0
   self.month = components.month ?? 0
   self.day = components.day ?? 0
   if self.year == 0 || self.month == 0 || self.day == 0
   {
    self.id = "invalid-\(date.timeIntervalSince1970)"
   }
   else
   {
    self.id = String(format: "%04d-%02d-%02d", year, month, day)
   }
  }
 }
}
