//
//  NetworkService.swift
//  NewsList
//
//  Created by Maxim Osyagin on 19.06.2021.
//

import Foundation
import UIKit

final class ApiManager {
    enum HTTPMethod: String {
        case get = "GET"
    }

    static var shared = ApiManager()

    var baseURL = "https://k8s-stage.apianon.ru/"


    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }

    private func requset<T: Codable>(method: HTTPMethod, params: [String: Any], path: String, complition: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        let requestURL = url.appendingPathComponent(path)

        var components = URLComponents(
            url: requestURL,
            resolvingAgainstBaseURL: false
        )

        var request = URLRequest(url: requestURL)

        if let queryParams = params as? [String: String] {
            let queryItems: [URLQueryItem] = queryParams.map { parameter in
                URLQueryItem(
                    name: parameter.key,
                    value: parameter.value
                )
            }
            components?.queryItems = queryItems
        } else {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed)
        }

        request.httpMethod = method.rawValue
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

        request.cachePolicy = .reloadIgnoringCacheData

        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error { complition(.failure(error)) }

            do {
                if let data = data {
                    let decoded = try self.decoder.decode(T.self, from: data)
                    complition(.success(decoded))
                }
            } catch let error {
                complition(.failure(error))
            }
        }).resume()
    }

    func getNews(first: Int, after: String, orderBy: String, closure: @escaping (NewsResponse) -> Void) {
        let parameters = [
            "first": first,
            "after": after,
            "orderBy": orderBy
        ] as [String : Any]

        self.requset(
            method: .get,
            params: parameters,
            path: "posts/v1/posts"
        ) { (complition: Result<NewsResponse, Error>) in
            switch complition {
            case .failure(let error):
                return
            case let .success(result):
                closure(result)
            }
        }
    }
}

extension Result where Success == Void {
    static var success: Result {
        return .success(())
    }
}
