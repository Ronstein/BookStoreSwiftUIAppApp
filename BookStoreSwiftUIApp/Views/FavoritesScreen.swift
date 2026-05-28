import SwiftUI
import BookStoreCore

struct FavoritesScreen: View {
    @State private var catalogViewModel: CatalogViewModel

    init(catalogViewModel: CatalogViewModel) {
        self._catalogViewModel = State(initialValue: catalogViewModel)
    }

    var body: some View {
        NavigationStack {
            Group {
                switch catalogViewModel.state {
                case .idle:
                    StatusView(message: "Los favoritos aparecerán aquí.", systemImage: "heart")
                case .loading:
                    StatusView(message: "Cargando favorito…", systemImage: "hourglass")
                case .loaded(let books):
                    let favorites = books.filter { catalogViewModel.isFavorite(book: $0) }
                    if favorites.isEmpty {
                        StatusView(message: "No hay libros favoritos aún.", systemImage: "heart")
                    } else {
                        List(favorites) { book in
                            NavigationLink(value: book) {
                                BookRowView(
                                    book: book,
                                    isFavorite: true,
                                    onFavoriteToggle: { catalogViewModel.toggleFavorite(book: book) }
                                )
                            }
                        }
                        .listStyle(.plain)
                    }
                case .error(let message):
                    StatusView(message: message, systemImage: "exclamationmark.triangle")
                }
            }
            .navigationTitle("Favoritos")
            .navigationDestination(for: Book.self) { book in
                BookDetailScreen(book: book, viewModel: catalogViewModel)
            }
        }
    }
}
