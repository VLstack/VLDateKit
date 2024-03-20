import Foundation

public
extension Date
{
 init(fr dateString: String)
 {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
  if let date = dateFormatter.date(from: dateString)
  {
   self = date
  }
  else
  {
   self = Date.now
  }
 }
 
 var endOfDay: Date?
 {
  let calendar = Calendar.current
  let selfComponents = calendar.dateComponents([.year, .month, .day], from: self)
  var components = selfComponents
  components.hour = 23
  components.minute = 59
  components.second = 59

  return calendar.date(from: components)
 }
 
 func isSame(_ date: Date?,
             toGranularity: Calendar.Component = .day) -> Bool
 {
  guard let date
  else { return false }
  
  return Calendar.current.isDate(self, equalTo: date, toGranularity: toGranularity)
 }
 
 func minutesDuration(to date: Date) -> Int?
 {
  let calendar = Calendar.current

  let componentsEnd = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
  guard let dateEnd = calendar.date(from: componentsEnd)
  else { return nil }

  let componentsSelf = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
  guard let dateSelf = calendar.date(from: componentsSelf)
  else { return nil }

  let components = calendar.dateComponents([.hour, .minute], from: dateSelf, to: dateEnd)

  if let hours = components.hour,
     let minutes = components.minute
  {
   return hours * 60 + minutes
  }

  return nil
 }
 
 var startOfDay: Date?
 {
  let calendar = Calendar.current
  let selfComponents = calendar.dateComponents([.year, .month, .day], from: self)
  var components = selfComponents
  components.hour = 0
  components.minute = 0
  components.second = 0

  return calendar.date(from: components)
 }
     
 var endOfDay: Date? 
 {
  let calendar = Calendar.current
  let selfComponents = calendar.dateComponents([.year, .month, .day], from: self)
  var components = selfComponents
  components.hour = 23
  components.minute = 59
  components.second = 59

  return calendar.date(from: components)
 }
}
