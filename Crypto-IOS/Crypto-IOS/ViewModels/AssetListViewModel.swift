import Foundation

@Observable
final class AssetListViewModel {
    
    var errorMessage: String?
    var assets: [Asset] = []
    
    func fetchAssets() async {
        let urlSession = URLSession.shared
        
        guard let url = URL(string: "https://rest.coincap.io/v3/assets?apiKey=") else {
            errorMessage = "Invalid URL"
            return
        }
       
        do {
            let (data, _) = try await urlSession.data(for: URLRequest(url: url))
            let assetsResponse = try JSONDecoder().decode(AssetsResponse.self, from: data)
            print(assets)
            self.assets = assetsResponse.data
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
}
