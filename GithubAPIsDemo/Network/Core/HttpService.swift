import Foundation

extension URLSession: URLSessionProtocol {}

// MARK: - URLSessionProtocol
protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

// MARK: - HttpServiceProtocol
protocol HttpServiceProtocol {
    func request<ModelType: Codable>(_ endpoint: Endpoint, modelType: ModelType.Type, responseData: @escaping (Result<ModelType, Error>) -> Void)
}

// MARK: - HttpService
class HttpService: HttpServiceProtocol {
    // MARK: - Public

    // MARK: - Initializer
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - HttpServiceProtocol
    func request<ModelType: Codable>(_ endpoint: Endpoint, modelType: ModelType.Type, responseData: @escaping (Result<ModelType, Error>) -> Void) {
        let request = endpoint.urlRequest()
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    responseData(.failure(error))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(ModelType.self, from: data)
                responseData(.success(result))
            } catch {
                responseData(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Private
    private var session: URLSessionProtocol
}
