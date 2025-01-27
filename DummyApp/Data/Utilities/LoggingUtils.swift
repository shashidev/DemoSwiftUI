//
//  LoggingUtils.swift
//  DummyApp
//
//  Created by Shashi Kumar on 27/01/25.
//

import Foundation

import Foundation

/// A utility function to log messages in debug mode.
///
/// - Parameter message: The message to be logged.
func debugLog(_ message: String) {
    #if DEBUG
    print(message)
    #endif
}
