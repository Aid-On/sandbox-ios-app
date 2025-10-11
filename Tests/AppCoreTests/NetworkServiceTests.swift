import XCTest
@testable import AppCore

final class NetworkServiceTests: XCTestCase {
    
    func testNetworkServiceExists() {
        let service = NetworkService.shared
        XCTAssertNotNil(service)
    }
    
    func testNetworkServiceIsSingleton() {
        let service1 = NetworkService.shared
        let service2 = NetworkService.shared
        XCTAssertTrue(service1 === service2)
    }
}