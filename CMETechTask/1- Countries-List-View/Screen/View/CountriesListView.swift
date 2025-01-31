//
//  CountriesListView.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import SwiftUI
import Commons

public struct CountriesListView: View {
    
    @StateObject var input: CountriesListViewModel.Input
    @StateObject var output: CountriesListViewModel.Output
    
    public init(viewModel: CountriesListViewModelProtocol) {
        _input = StateObject(wrappedValue: viewModel.input)
        _output = StateObject(wrappedValue: viewModel.output)
    }
    
    @ViewBuilder
    var FavBtn: some View {
        ZStack {
            Button(action: {
                input
                    .ipActions
                    .send(
                        .toFavScreen
                    )
            }) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(.title2)
            }
            if output.FavCount > 0 {
                Text("\(output.FavCount)")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
            }
        }
    }
    
    public var body: some View {
        VStack {
            
            HStack {
                TextField("Search here...", text: $input.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                if output.FavCount > 0 {
                    FavBtn
                }
            }
            .padding()
            
            List {
                ForEach(output.presentableCountries, id: \.name) { item in
                    Button(action: {
                        input
                            .ipActions
                            .send(
                                .addToFav(item)
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
            }
        }
        .commonIOModifiers(vmOutput: output, viewonAppear: {
            input
                .ipActions
                .send(
                    .updateCount
                )
        }, viewDidLoad: {
            input
                .ipActions
                .send(.fetchCountries)
        })
    }
}
