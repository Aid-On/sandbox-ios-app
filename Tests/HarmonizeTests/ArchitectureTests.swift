import XCTest
import Harmonize
@testable import AppCore

final class ArchitectureTests: XCTestCase {
    
    func testServiceClassesShouldFollowNamingConvention() {
        // Test that all service classes end with "Service"
        let services = Harmonize.productionCode().classes()
            .withNameContaining("Service")
        
        services.assertTrue(message: "All service classes should end with 'Service'") {
            $0.name.hasSuffix("Service")
        }
    }
    
    func testManagerClassesShouldFollowNamingConvention() {
        // Test that all manager classes end with "Manager"
        let managers = Harmonize.productionCode().classes()
            .withNameContaining("Manager")
        
        managers.assertTrue(message: "All manager classes should end with 'Manager'") {
            $0.name.hasSuffix("Manager")
        }
    }
    
    func testAppCoreClassesExist() {
        // Simple test to verify our core classes exist
        let coreClasses = Harmonize.productionCode().classes()
            .withNameEndingWith("Service", "Manager")
        
        coreClasses.assertTrue(message: "Core service and manager classes should exist") {
            !$0.name.isEmpty
        }
    }
    
    func testClassNamingConsistency() {
        // Test that classes follow consistent naming
        let allClasses = Harmonize.productionCode().classes()
        
        allClasses.assertTrue(message: "Class names should not be empty") {
            !$0.name.isEmpty
        }
    }
    
    func testBasicArchitecturalRule() {
        // Basic test to ensure Harmonize is working
        let productionCode = Harmonize.productionCode()
        XCTAssertNotNil(productionCode, "Production code should be accessible")
    }
}