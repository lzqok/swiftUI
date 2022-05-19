//
//  NetManager.swift
//  TestSwiftUI
//
//  Created by 柳宗青 on 2022/5/16.
//

import UIKit
import Combine

class NetManager: NSObject {
    var shareInstance: NetManager {
        struct Static {
            static let manager = NetManager()
        }
        return Static.manager
    }
    
    private override init() {
        super.init()
    }
    
    override func copy() -> Any {
        return self
    }
    
    override func mutableCopy() -> Any {
        return self
    }
    
    func request() {
        let api = "https://swapi.dev/api/people"
        
    }
    
}


struct APIClient {
    struct Response<T> { // 1
           let value: T
           let response: URLResponse
       }

       func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> { // 2
           return URLSession.shared
               .dataTaskPublisher(for: request) // 3
               .tryMap { result -> Response<T> in
                   let value = try JSONDecoder().decode(T.self, from: result.data) // 4
                   return Response(value: value, response: result.response) // 5
               }
               .receive(on: DispatchQueue.main) // 6
               .eraseToAnyPublisher() // 7
       }
}


import Foundation

struct People: Codable, Identifiable {
    var id = UUID()
    let name_cn: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    let created: String
    let edited: String
    let url: String


    enum CodingKeys: String, CodingKey {
        case name_cn = "name"
        case height
        case mass
        case hair_color
        case skin_color
        case eye_color
        case birth_year
        case gender
        case homeworld
        case created
        case edited
        case url
    }
}


struct PeopleResponse: Codable {
    let count: Int
    let results: [People]
    let previous: String?
    let next: String?

    enum CodingKeys: String, CodingKey {
        case count
        case results
        case previous
        case next
    }
}

enum Folo {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://swapi.dev/api/")!
}

// 2
enum APIPath: String {
    case resourceList = "people"
}

extension Folo {

    static func request(_ path: APIPath, _ queryItems: [URLQueryItem]) -> AnyPublisher<PeopleResponse, Error> {
        // 3
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        components.queryItems = queryItems // 4

        let request = URLRequest(url: components.url!)

        return apiClient.run(request) // 5
            .map(\.value) // 6
            .eraseToAnyPublisher() // 7
    }
}


class PeopleViewModel: ObservableObject {
    @Published var peopleList: [People] = []
    var cancellationToken: AnyCancellable?
    init() {
        getPeopleList()
    }
    
    func getPeopleList() {
        cancellationToken = Folo.request(.resourceList, []).mapError({ (error) -> Error in
            print(error)
            return error
        }).sink(receiveCompletion: { _ in
            
        }, receiveValue: { (response) in
            self.peopleList = response.results
        })

    }
}
