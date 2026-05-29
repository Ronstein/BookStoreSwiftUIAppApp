import SwiftUI
import BookStoreCore

struct CatalogScreen: View {
    @State private var viewModel: CatalogViewModel

    init(viewModel: CatalogViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle:
                    StatusView(message: "Busca libros usando el campo superior.", systemImage: "book")
                case .loading:
                    StatusView(message: "Cargando catálogo…", systemImage: "hourglass")
                case .loaded(let books):
                    if books.isEmpty {
                        StatusView(message: "No se encontraron libros.", systemImage: "magnifyingglass")
                    } else {
                        List(books) { book in
                            NavigationLink(value: book) {
                                BookRowView(
                                    book: book,
                                    isFavorite: viewModel.isFavorite(book: book),
                                    onFavoriteToggle: { viewModel.toggleFavorite(book: book) }
                                )
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .background(Color(.systemGroupedBackground))
                    }
                case .error(let message):
                    StatusView(message: message, systemImage: "exclamationmark.triangle")
                }
            }
            .navigationTitle("Catálogo")
            .task {
                if case .idle = viewModel.state {

                        await viewModel.loadBooks()

                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            await viewModel.loadBooks()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.title2)
                            .padding(8)
                    }
                }
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailScreen(book: book, viewModel: viewModel)
            }
        }
    }
}
