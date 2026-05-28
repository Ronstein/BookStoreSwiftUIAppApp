import Foundation

public struct FavoriteBookUseCase {

    private let storage: FavoriteStorage

    public init(
        storage: FavoriteStorage = UserDefaultsFavoriteStorage()
    ) {
        self.storage = storage
    }

    public func loadFavorites() -> Set<String> {
        storage.loadFavoriteIDs()
    }

    public func toggleFavorite(
        id: String,
        currentFavorites: Set<String>
    ) -> Set<String> {

        var newFavorites = currentFavorites

        if newFavorites.contains(id) {

            newFavorites.remove(id)

        } else {

            newFavorites.insert(id)
        }

        storage.saveFavoriteIDs(newFavorites)

        return newFavorites
    }
}
