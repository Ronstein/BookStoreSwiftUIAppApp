import Foundation

public struct UserDefaultsFavoriteStorage: FavoriteStorage {

    private let key = "BookStore.FavoriteBooks"

    public init() {}

    public func loadFavoriteIDs() -> Set<String> {

        let array =
            UserDefaults.standard.stringArray(
                forKey: key
            ) ?? []

        return Set(array)
    }

    public func saveFavoriteIDs(_ ids: Set<String>) {

        UserDefaults.standard.set(
            Array(ids),
            forKey: key
        )
    }
}
