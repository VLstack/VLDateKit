import Foundation

public extension DateFormatter
{
 static let dayOfWeekShort: DateFormatter =
 {
  let formatter = DateFormatter()
  formatter.dateFormat = "E"
  
  return formatter
 }()
 
 static let ddMM: DateFormatter =
 {
  let formatter = DateFormatter()
  formatter.dateFormat = "dd/MM"
  
  return formatter
 }()
 
 static let ddMMyyyy: DateFormatter =
 {
  let formatter = DateFormatter()
  formatter.dateFormat = "dd/MM/yyyy"

  return formatter
 }()
}
