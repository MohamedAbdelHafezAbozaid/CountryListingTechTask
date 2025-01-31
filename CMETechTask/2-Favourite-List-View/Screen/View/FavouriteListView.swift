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
                    Button(action: {
                        input
                            .ipActions
                            .send(
                                .toDetails(item)
                            )
                    }) {
                        Text(item.name)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8) 
                    }
                    .buttonStyle(PlainButtonStyle())
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
        }, errorCallBackAction: {
            
        })
    }
}
