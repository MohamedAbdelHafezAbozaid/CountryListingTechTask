//
//  GetCountriesUseCase_Tests.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//
import XCTest
import AppCore
import CMETechTask

final class GetCountriesUseCaseTests: XCTestCase {
    private func makeSutForSuccess() -> GetCountriesUseCase {
        SpyGetCountriesUseCase(
            countriesRepo: CountriesLoaderRepositorySpy(
                spy: CountriesLoaderApiSuccessSpy(
                    httpClient: MockHTTPClient(
                        mockFileName: "MockCountries"
                    )
                )
            )
        )
    }
    
    func test_GetCountriesUseCase_getCountries_shouldReturnCountriesSuccessfully() async {
        do {
            // Arrange
            let sut = makeSutForSuccess()
            // Act
            let countries = try await sut.getAllCountries()
            // Assert
            XCTAssertEqual(countries.count, 6)
            XCTAssertEqual(countries.first?.name, "South Georgia and the South Sandwich Islands")
        } catch {
            XCTFail("Async error thrown: \(error)")
        }
    }
    
    // MARK: - Helpers
    
    private class SpyGetCountriesUseCase: GetCountriesUseCase {
        // MARK: - Properties
        
        var countriesRepo: CountriesLoaderRepositoryProtocol
        
        // MARK: - Methods
        
        init(countriesRepo: CountriesLoaderRepositoryProtocol) {
            self.countriesRepo = countriesRepo
        }
    }
}
