import Foundation
import Dependencies

@Observable
final class FavouritesViewModel {
    
    @ObservationIgnored
    @Dependency(\.assetsApiClient) var apiClient
    
    @ObservationIgnored
    @Dependency(\.authClient) var authClient
    
    var favourites: [String] = []
    var assets: [Asset] = []
    
    func getFavourites() async {
        do {
            let user = try authClient.getCurrentUser()
            favourites = try await apiClient.fetchFavourites(user)
            for favourite in favourites {
                let asset = try await apiClient.fetchAsset(favourite)
                assets += [asset]
            }
        } catch {
            // handle errors
        }
    }
}
