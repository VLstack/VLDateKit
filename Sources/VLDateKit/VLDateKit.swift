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
 
 func isSame(_ date: Date?,
             toGranularity: Calendar.Component = .day) -> Bool
 {
  guard let date
  else { return false }
  
  return Calendar.current.isDate(self, equalTo: date, toGranularity: toGranularity)
 }
 
 func yesterday() -> Date?
 {
  let calendar = Calendar.current
  if let yesterday = calendar.date(byAdding: .day, value: -1, to: self)
  {
   return yesterday
  }
  
  return nil
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
 
}
