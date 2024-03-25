import XCTest
@testable import VLDateKit

final class VLDateKitTests: XCTestCase 
{
//    func testExample() throws {
//        // XCTest Documentation
//        // https://developer.apple.com/documentation/xctest
//
//        // Defining Test Cases and Test Methods
//        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
//    }
 
 func testYesterday()
 {
  var dateComponents: DateComponents = .init()
  dateComponents.year = 2024
  dateComponents.month = 3
  dateComponents.day = 20
  dateComponents.hour = 13
  dateComponents.minute = 16
  dateComponents.second = 49
  dateComponents.nanosecond = 0
  
  guard let date: Date = Calendar.current.date(from: dateComponents)
  else { XCTFail("Cannot create base date"); return }
  
  guard let yesterday: Date = date.yesterday()
  else { XCTFail("Cannot create yesterday"); return }
  
  guard let dateMinus1: Date = Calendar.current.date(byAdding: .day, value: -1, to: date)
  else { XCTFail("Cannot create dateMinus1"); return }

  XCTAssert(yesterday.isSame(dateMinus1, toGranularity: .day), "Yesterday is invalid")
 }
}
