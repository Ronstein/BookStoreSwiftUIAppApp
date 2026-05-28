import Foundation
import BookStoreCore

@MainActor
@Observable
final class CatalogViewModel {

    var state: LoadingState<[Book]> = .idle

    var favoriteIDs: Set<String> = []
    var cartItems: [String: Int] = [:]

    private let fetchBooksUseCase: FetchBooksUseCase
    private let favoriteUseCase: FavoriteBookUseCase
    private let cartUseCase: CartUseCase

    init(
        fetchBooksUseCase: FetchBooksUseCase = FetchBooksUseCase(),
        favoriteUseCase: FavoriteBookUseCase = FavoriteBookUseCase(),
        cartUseCase: CartUseCase = CartUseCase()
    ) {
        self.fetchBooksUseCase = fetchBooksUseCase
        self.favoriteUseCase = favoriteUseCase
        self.cartUseCase = cartUseCase

        self.favoriteIDs =
            favoriteUseCase.loadFavorites()

        self.cartItems =
            cartUseCase.loadCartItems()
    }

    func loadBooks() async {

        state = .loading

        do {

            let books =
                try await fetchBooksUseCase.execute()

            state = .loaded(books)

        } catch {

            let message =
                (error as? LocalizedError)?
                .errorDescription
                ?? "Ocurrió un error inesperado"

            state = .error(message)
        }
    }

    var books: [Book] {

        guard case .loaded(let books) = state else {
            return []
        }

        return books
    }

    func toggleFavorite(book: Book) {

        favoriteIDs =
            favoriteUseCase.toggleFavorite(
                id: book.id,
                currentFavorites: favoriteIDs
            )
    }

    func isFavorite(book: Book) -> Bool {

        favoriteIDs.contains(book.id)
    }

    func addToCart(book: Book) {

        cartItems =
            cartUseCase.addBook(
                book,
                currentItems: cartItems
            )
    }

    func removeFromCart(book: Book) {

        cartItems =
            cartUseCase.removeBook(
                book,
                currentItems: cartItems
            )
    }
}
