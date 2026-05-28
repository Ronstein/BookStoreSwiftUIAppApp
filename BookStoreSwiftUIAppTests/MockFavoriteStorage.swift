import Foundation
import BookStoreCore

final class MockFavoriteStorage: FavoriteStorage {

    var ids: Set<String> = []

    func loadFavoriteIDs() -> Set<String> {
        ids
    }

    func saveFavoriteIDs(
        _ ids: Set<String>
    ) {
        self.ids = ids
    }
}
