import VLstackNamespace
import Foundation

extension DateFormatter
{
 /// Short weekday symbols, as returned by `DateFormatter().shortWeekdaySymbols`.
 /// Example: ["Sun", "Mon", "Tue", ...]
 internal static let symbolsWeekday_short: [ String ] = { DateFormatter().shortWeekdaySymbols }()

 /// Very short weekday symbols, as returned by `DateFormatter().veryShortWeekdaySymbols`.
 /// Example: ["S", "M", "T", ...]
 internal static let symbolsWeekday_veryShort: [ String ] = { DateFormatter().veryShortWeekdaySymbols }()

 /// Full weekday symbols, as returned by `DateFormatter().weekdaySymbols`.
 /// Example: ["Sunday", "Monday", "Tuesday", ...]
 internal static let symbolsWeekday: [ String ] = { DateFormatter().weekdaySymbols }()
}

extension VLstack
{
 /// Represents a weekday, compatible with `Calendar` weekday raw values.
 /// Sunday = 1, Monday = 2, ..., Saturday = 7.
 /// Provides utility properties for symbols, ordering, and date comparisons.
 public enum Weekday: Int, Identifiable, CaseIterable, Codable, Equatable, Sendable
 {
  /// The identifier of the weekday, equal to its raw value.
  public var id: Self.RawValue { self.rawValue }

  case monday = 2
  case tuesday = 3
  case wednesday = 4
  case thursday = 5
  case friday = 6
  case saturday = 7
  case sunday = 1

  /// Safe initializer using a raw value. Falls back to a default if the raw value is invalid.
  /// - Parameters:
  ///   - safe: The raw weekday value (1 = Sunday, 2 = Monday, ..., 7 = Saturday).
  ///   - fallback: The weekday to use if the provided value is invalid (default is `.sunday`).
  @inlinable
  public init(safe: Self.RawValue,
              fallback: Self = .sunday)
  {
   self = Self(rawValue: safe) ?? fallback
  }

  /// The integer value used by `Calendar` for this weekday.
  /// Sunday = 1, Monday = 2, ..., Saturday = 7.
  @inlinable
  public var dateComponentValue: Int { self.rawValue }

  /// Returns the zero-based index of this weekday assuming Monday as the first day of the week.
  /// Monday = 0, Tuesday = 1, ..., Sunday = 6.
  @inlinable
  public var indexMondayFirst: Int
  {
   self.rawValue - 1
  }

  /// Checks if this weekday matches the given date.
  /// - Parameters:
  ///   - date: The date to compare with (default is `.now`).
  ///   - calendar: The calendar to use for comparison (default is `.current`).
  /// - Returns: `true` if the date falls on this weekday, `false` otherwise.
  @inlinable
  public func isToday(for date: Date = .now,
                      calendar: Calendar = .current) -> Bool
  {
   calendar.component(.weekday, from: date) == self.dateComponentValue
  }

  /// Returns the weekday that comes after this one.
  /// Example: `.monday.next` → `.tuesday`
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

  /// Returns the weekday that comes before this one.
  /// Example: `.monday.previous` → `.sunday`
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

  /// Short symbol of the weekday, e.g., "Mon".
  public var shortWeekdaySymbol: String { DateFormatter.symbolsWeekday_short[self.symbolValue] }

  /// Zero-based index used to access weekday symbol arrays.
  /// Corresponds to the raw value minus one (Sunday = 0, Monday = 1, ..., Saturday = 6).
  @inlinable
  public var symbolValue: Int { self.rawValue - 1 }

  /// Very short symbol of the weekday, e.g., "M".
  public var veryShortWeekdaySymbol: String { DateFormatter.symbolsWeekday_veryShort[self.symbolValue] }

  /// Full name of the weekday, e.g., "Monday".
  public var weekdaySymbol: String { DateFormatter.symbolsWeekday[self.symbolValue] }
 }
}
