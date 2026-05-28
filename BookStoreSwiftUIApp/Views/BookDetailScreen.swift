import SwiftUI
import BookStoreCore

struct BookDetailScreen: View {
    let book: Book
    @State private var viewModel: CatalogViewModel

    init(book: Book, viewModel: CatalogViewModel) {
        self.book = book
        self._viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                BookCoverView(url: book.coverImageURL)

                VStack(alignment: .leading, spacing: 12) {
                    Text(book.title)
                        .font(.title)
                        .bold()

                    Text(book.author)
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    Text(book.formattedPrice)
                        .font(.title2)
                        .bold()

                    Text("Publicado: \(book.publishYear)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Divider()

                    Text(book.description)
                        .font(.body)
                }
                .padding(.horizontal)

                HStack(spacing: 16) {
                    Button(action: { viewModel.addToCart(book: book) }) {
                        Label("Agregar al carrito", systemImage: "cart.badge.plus")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    Button(action: { viewModel.toggleFavorite(book: book) }) {
                        Image(systemName: viewModel.isFavorite(book: book) ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundStyle(viewModel.isFavorite(book: book) ? .pink : .primary)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }
}
