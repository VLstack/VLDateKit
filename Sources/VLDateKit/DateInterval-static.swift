import Foundation

extension DateInterval
{
 /// Creates a `DateInterval` from two optional dates, ensuring the start is before the end.
  /// - Parameters:
  ///   - first: The first date.
  ///   - last: The second date.
  /// - Returns: A `DateInterval` from the earlier date to the later date, or `nil` if either date is `nil` or both are equal.
 public static func get(from first: Date?,
                        to last: Date?) -> DateInterval?
 {
  guard let first,
        let last,
        first != last
  else { return nil }

  return DateInterval(start: min(first, last),
                      end: max(first, last))
 }
}
