//
//  DetailsView.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import SwiftUI
import Commons

public struct DetailsView: View {
    @StateObject var input: DetailsViewModel.Input
    @StateObject var output: DetailsViewModel.Output
    
    public init(viewModel: DetailsViewModelProtocol) {
        _input = StateObject(wrappedValue: viewModel.input)
        _output = StateObject(wrappedValue: viewModel.output)
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Name :-  \(output.country.name) \(output.country.flag)")
                Text("Capital :-  \(output.country.capital)")
                Text("currency :-  \(output.country.currency)")
            }
            .font(.headline)
        }
    }
}
