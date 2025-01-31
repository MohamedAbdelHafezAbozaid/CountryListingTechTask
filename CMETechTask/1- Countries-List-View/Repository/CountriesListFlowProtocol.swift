//
//  CountriesListFlowProtocol.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import protocol AppCore.GetCountriesUseCase
import protocol AppCore.SearchCountriesUseCase

public typealias CountriesListFlowProtocol = GetCountriesUseCase & SearchCountriesUseCase
