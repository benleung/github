import Foundation
import os

public protocol GithubApiProtocol {
    associatedtype Response: Codable
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

/// protocol for calling github's api
extension GithubApiProtocol {
    private var baseUrl: String { "https://api.github.com/" }
    private var token: String {
        // TODO: better keep this value to a seperate secret file
        "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"
    }

    public func perform() async throws -> Response {
        let logger = Logger(subsystem: "github", category: "api")
        guard var urlComponents = URLComponents(string: "\(baseUrl)\(path)") else {
            throw APIError.unexpected
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            throw APIError.unexpected
        }
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw APIError.badResponse(nil)
        }

        guard (200...299).contains(response.statusCode) else {
            logger.error("badResponse (status code): \(response.statusCode)")
            logger.error("\(String(decoding: data, as: UTF8.self))")
            throw APIError.badResponse(response.statusCode)
        }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let result = try decoder.decode(Response.self, from: data)
            return result
        } catch {
            logger.error("\(error.localizedDescription)")
            throw APIError.unexpected
        }
    }
}
