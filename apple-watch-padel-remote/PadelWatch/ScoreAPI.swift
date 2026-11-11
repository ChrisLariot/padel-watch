import Foundation

struct MatchView: Decodable {
    let teams: [String]
    let points: [String]
    let games: [Int]
    let server: Int?
    let over: Bool
}

enum ScoreAPI {
    static let base = URL(string: "https://scorerecord.lovable.app/api/public/score")!

    static func fetch(pin: String) async throws -> MatchView {
        var c = URLComponents(url: base, resolvingAgainstBaseURL: false)!
        c.queryItems = [URLQueryItem(name: "pin", value: pin)]
        let (data, resp) = try await URLSession.shared.data(from: c.url!)
        try check(resp)
        return try JSONDecoder().decode(MatchView.self, from: data)
    }

    static func send(pin: String, action: String) async throws -> MatchView {
        var req = URLRequest(url: base)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONSerialization.data(withJSONObject: ["pin": pin, "action": action])
        let (data, resp) = try await URLSession.shared.data(for: req)
        try check(resp)
        return try JSONDecoder().decode(MatchView.self, from: data)
    }

    private static func check(_ r: URLResponse) throws {
        let code = (r as? HTTPURLResponse)?.statusCode ?? 0
        if code == 404 { throw APIError.notFound }
        if code != 200 { throw APIError.http(code) }
    }
}

enum APIError: LocalizedError {
    case notFound, http(Int)
    var errorDescription: String? {
        switch self {
        case .notFound: return "No match for that PIN"
        case .http(let c): return "Error \(c)"
        }
    }
}
