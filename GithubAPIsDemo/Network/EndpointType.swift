import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var jsonParameters: [String: Any] { get }
    var headers: [String: String]? { get }
    func urlRequest() -> URLRequest
}

extension EndpointType {
    func urlRequest() -> URLRequest {
        let urlPath = [self.baseURL.absoluteString, self.path].joined()
        let url = URL(string: urlPath)!
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        
        self.headers?.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if self.method != .get {
            request.httpBody = try? JSONSerialization.data(withJSONObject: self.jsonParameters, options: [])
        }

        return request
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
