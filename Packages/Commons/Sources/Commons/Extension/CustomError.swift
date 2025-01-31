//
//  CustomError.swift
//  Commons
//
//  Created by mohamed ahmed on 31/01/2025.
//
import Foundation

public enum CustomError: Error, LocalizedError {
    case maxAmountReached
    case emptyFav
    
    public var errorDescription: String? {
        switch self {
        case .maxAmountReached:
            return "U can add only 5 items to favourite by Max."
        case .emptyFav:
            return "Favourite List Can't be Empty. add More items to delete this one"
        }
    }
}
