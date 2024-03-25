import Foundation

public extension DateFormatter
{
 @available(*, deprecated, message: "Define your own format in your project")
 static let dayOfWeekShort: DateFormatter =
 {
  let formatter = DateFormatter()
  formatter.dateFormat = "E"
  
  return formatter
 }()
 
 @available(*, deprecated, message: "Define your own format in your project")
 static let ddMM: DateFormatter =
 {
  let formatter = DateFormatter()
  formatter.dateFormat = "dd/MM"
  
  return formatter
 }()
 
 @available(*, deprecated, message: "Define your own format in your project")
 static let ddMMyyyy: DateFormatter =
 {
  let formatter = DateFormatter()
  formatter.dateFormat = "dd/MM/yyyy"

  return formatter
 }()
}
