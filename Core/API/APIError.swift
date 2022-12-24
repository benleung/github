import Foundation

public enum APIError: Error {
    /// response code
    case badResponse(Int?)
    case custom(Error)
    case unexpected
}

