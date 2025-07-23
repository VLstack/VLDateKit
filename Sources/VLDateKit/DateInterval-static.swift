import Foundation

extension DateInterval
{
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
