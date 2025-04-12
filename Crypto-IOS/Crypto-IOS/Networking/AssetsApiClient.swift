import Dependencies
import Foundation
import XCTestDynamicOverlay

struct AssetsApiClient {
    var fetchAllAssets: () async throws -> [Asset]
}

enum NetworkingError: Error {
    case invalidURL
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        }
    }
}

extension AssetsApiClient: DependencyKey {
    static var liveValue: AssetsApiClient {
        .init(
            fetchAllAssets: {
                let urlSession = URLSession.shared
                
                guard let url = URL(string: "https://rest.coincap.io/v3/assets?apiKey=6b485c584d692e1a35d6025d8fae446d0458f1ff80c1722ab2173b6f9ae99cea") else {
                    throw NetworkingError.invalidURL
                }
                
                let (data, _) = try await urlSession.data(for: URLRequest(url: url))
                let assetsResponse = try JSONDecoder().decode(AssetsResponse.self, from: data)
                
                return assetsResponse.data
            }
        )
    }
    
    static var previewValue: AssetsApiClient {
        .init(
            fetchAllAssets: {[
                .init(
                    id: "bitcoin",
                    name: "Bitcoin",
                    symbol: "BTC",
                    priceUsd: "82845.8465132",
                    changePercent24Hr: "4.456120"
                ),
                .init(
                    id: "ethereum",
                    name: "Ethereum",
                    symbol: "ETH",
                    priceUsd: "1284.48651",
                    changePercent24Hr: "-2.84651320"
                ),
                .init(
                    id: "solana",
                    name: "Solana",
                    symbol: "SOL",
                    priceUsd: "423.78451513",
                    changePercent24Hr: "2.54120"
                )
            ]}
        )
    }
    
    static var testValue: AssetsApiClient {
        .init(fetchAllAssets: {
            XCTFail("AssetsApiClient.fetchAllAssets is unimplemented")
//            reportIssue("AssetsApiClient.fetchAllAssets is unimplemented")
            return []
        })
    }
}

extension DependencyValues {
    var assetsApiClient: AssetsApiClient {
        get { self[AssetsApiClient.self] }
        set { self[AssetsApiClient.self] = newValue }
    }
}


//
//
//protocol AssetsApiProtocol {
//    func getAssets() async throws -> [Asset]
//}
//
//
//struct AssetsApiService: AssetsApiProtocol {
//    func getAssets() async throws -> [Asset] {
//        let urlSession = URLSession.shared
//
//        guard let url = URL(string: "https://4ff399d1-53e9-4a28-bc99-b7735bad26bd.mock.pstmn.io/v3/assets") else {
//            throw NetworkingError.invalidURL
//        }
//
//        let (data, _) = try await urlSession.data(for: URLRequest(url: url))
//        let assetsResponse = try JSONDecoder().decode(AssetsResponse.self, from: data)
//
//        return assetsResponse.data
//    }
//}
//
//struct AssetsApiServicePreview: AssetsApiProtocol {
//    func getAssets() async throws -> [Asset] {
//        [
//            .init(
//                id: "bitcoin",
//                name: "Bitcoin",
//                symbol: "BTC",
//                priceUsd: "89111121.2828",
//                changePercent24Hr: "8.992929292"
//            ),
//            .init(
//                id: "ethereum",
//                name: "Ethereum",
//                symbol: "ETH",
//                priceUsd: "1289.282828",
//                changePercent24Hr: "-1.2323232323"
//            ),
//            .init(
//                id: "solana",
//                name: "Solana",
//                symbol: "SOL",
//                priceUsd: "500.29292929",
//                changePercent24Hr: "9.2828282"
//            )
//        ]
//    }
//}
