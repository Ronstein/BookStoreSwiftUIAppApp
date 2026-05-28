import Foundation

public protocol FavoriteStorage {
    func loadFavoriteIDs() -> Set<String>
    func saveFavoriteIDs(_ ids: Set<String>)
}
