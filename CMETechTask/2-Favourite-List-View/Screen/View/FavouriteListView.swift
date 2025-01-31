//
//  FavouriteListView.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import SwiftUI
import Commons

public struct FavouriteListView: View {
    
    @StateObject var input: FavouriteListViewModel.Input
    @StateObject var output: FavouriteListViewModel.Output
    
    public init(viewModel: FavouriteListViewModelProtocol) {
        _input = StateObject(wrappedValue: viewModel.input)
        _output = StateObject(wrappedValue: viewModel.output)
    }
    
    public var body: some View {
        VStack {
            List {
                ForEach(output.countries, id: \.name) { item in
                    Text(item.name)
                        .onTapGesture {
                            input
                                .ipActions
                                .send(
                                    .toDetails(item)
                                )
                        }
                }
                .onDelete(perform: { offsets in
                    input
                        .ipActions
                        .send(
                            .delete(offsets: offsets)
                        )
                })
            }
            .toolbar {
                EditButton() 
            }
        }
        .commonIOModifiers(vmOutput: output, viewDidLoad: {
            input
                .ipActions
                .send(.fetchSavedCountries)
        })
    }
}
