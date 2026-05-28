import Foundation
import BookStoreCore

@MainActor
@Observable
final class FavoritesViewModel {

    var favoriteIDs: Set<String>

    init(
        favoriteIDs: Set<String> = []
    ) {
        self.favoriteIDs = favoriteIDs
    }

    func isFavorite(
        book: Book
    ) -> Bool {

        favoriteIDs.contains(book.id)
    }

    func filterFavorites(
        from books: [Book]
    ) -> [Book] {

        books.filter {
            favoriteIDs.contains($0.id)
        }
    }
}
