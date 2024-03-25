import Foundation

public extension Date
{
 static var firstDayOfWeek = Calendar.current.firstWeekday
 
 static var firstLetterOfWeekday: [ String ]
 {
  let calendar = Calendar.current
  let weekdays = calendar.shortWeekdaySymbols
  
  return weekdays.map
  {
   weekday in
   guard let firstLetter = weekday.first
   else { return "" }
   
   return String(firstLetter)
  }
 }
 
 static var firstLetterOfWeekDayCapitalized: [ String ]
 {
  firstLetterOfWeekday.map { $0.capitalized }
 }
 
 static var firstLetterOfWeekDayLowered: [ String ]
 {
  firstLetterOfWeekday.map { $0.localizedLowercase }
 }

 static var fullMonthNames: [ String ]
 {
  let formatter = DateFormatter()
  formatter.locale = Locale.current
  formatter.setLocalizedDateFormatFromTemplate("MMMM")
  
  return (1...12).compactMap
  {
   month in
   guard let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
   else { return "?" }
   
   return formatter.string(from: date)
//   return date.map { formatter.string(from: $0) }
  }
 }
}
