import VLstackNamespace
import Foundation

extension DateFormatter
{
 internal static let symbolsWeekday_short: [ String ] = { DateFormatter().shortWeekdaySymbols }()
 internal static let symbolsWeekday_veryShort: [ String ] = { DateFormatter().veryShortWeekdaySymbols }()
 internal static let symbolsWeekday: [ String ] = { DateFormatter().weekdaySymbols }()
}

extension VLstack
{
 public enum Weekday: Int, Identifiable, CaseIterable, Codable, Equatable, Sendable
 {
  public var id: Self.RawValue { self.rawValue }

  case monday = 2
  case tuesday = 3
  case wednesday = 4
  case thursday = 5
  case friday = 6
  case saturday = 7
  case sunday = 1

  @inlinable
  public init(safe: Self.RawValue,
              fallback: Self = .sunday)
  {
   self = Self(rawValue: safe) ?? fallback
  }

  public var dateComponentValue: Int { self.rawValue }

  public var indexMondayFirst: Int
  {
   self.rawValue - 1
  }

  public func isToday(for date: Date = .now,
                      calendar: Calendar = .current) -> Bool
  {
   calendar.component(.weekday, from: date) == self.dateComponentValue
  }

  public var next: VLstack.Weekday
  {
   switch self
   {
    case .sunday: .monday
    case .monday: .tuesday
    case .tuesday: .wednesday
    case .wednesday: .thursday
    case .thursday: .friday
    case .friday: .saturday
    case .saturday: .sunday
   }
  }

  public var previous: VLstack.Weekday
  {
   switch self
   {
    case .sunday: .saturday
    case .monday: .sunday
    case .tuesday: .monday
    case .wednesday: .tuesday
    case .thursday: .wednesday
    case .friday: .thursday
    case .saturday: .friday
   }
  }

  public var shortWeekdaySymbol: String { DateFormatter.symbolsWeekday_short[self.symbolValue] }

  public var symbolValue: Int { self.rawValue - 1 }

  public var veryShortWeekdaySymbol: String { DateFormatter.symbolsWeekday_veryShort[self.symbolValue] }

  public var weekdaySymbol: String { DateFormatter.symbolsWeekday[self.symbolValue] }
 }
}
