import Foundation

public protocol GithubApiProtocol {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

/// protocol for calling githubApiProtocl api
extension GithubApiProtocol {
    private var baseUrl: String { "https://api.github.com/" }
    private var token: String {
        // TODO: better keep this value to a seperate secret file
        "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"
    }

    public func perform<T: Decodable>(decode decodable: T.Type) async throws -> T {
        guard var urlComponents = URLComponents(string: "\(baseUrl)\(path)") else {
            throw APIError.unexpected
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            throw APIError.unexpected
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Accept": "application/vnd.github+json",
            "Authorization": "Bearer \(token)",
            "X-GitHub-Api-Version": "2022-11-28"
        ]
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw APIError.badResponse(nil)
        }

        guard (200...299).contains(response.statusCode) else {
            throw APIError.badResponse(response.statusCode)
        }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw APIError.unexpected
        }
        return result
    }
}
