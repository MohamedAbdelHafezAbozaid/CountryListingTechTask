//
//  CountriesLoaderRepositorySpy_Tests.swift
//  AppCore
//
//  Created by mohamed ahmed on 30/01/2025.
//

import XCTest
import AppCore
import CMETechTask

final class CountriesLoaderRepositorySpyTests: XCTestCase {
    private func makeSut(spy: CountriesLoaderAPI) -> CountriesLoaderRepositorySpy {
        CountriesLoaderRepositorySpy(spy: spy)
    }

    private func makeSuccessCountriesApis() -> CountriesLoaderAPI {
        CountriesLoaderApiSuccessSpy(
            httpClient: MockHTTPClient(
                mockFileName: "MockCountries"
            )
        )
    }

    func test_CountriesLoaderRepositorySpy_getAllCountries_shouldgetAllCountriesSuccessfully() async {
        do {
            // Arrange
            let sut = makeSut(spy: makeSuccessCountriesApis())
            // Act
            let countries = try await sut.loadCountries()
            // Assert
            XCTAssertEqual(countries.count, 6)
        } catch {
            XCTFail("Async error thrown: \(error)")
        }
    }
}
