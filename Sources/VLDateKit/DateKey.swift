import VLstackNamespace
import Foundation

extension VLstack
{
 public struct DateKey: Identifiable, Hashable, Sendable
 {
  public let id: String
  public let year: Int
  public let month: Int
  public let day: Int

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
