import SwiftUI
import BookStoreCore

struct CartScreen: View {
    @State private var catalogViewModel: CatalogViewModel
    @State private var cartViewModel: CartViewModel

    init(catalogViewModel: CatalogViewModel, cartViewModel: CartViewModel) {
        self._catalogViewModel = State(initialValue: catalogViewModel)
        self._cartViewModel = State(initialValue: cartViewModel)
    }

    var cartBooks: [Book] {
        switch catalogViewModel.state {
        case .loaded(let books):
            return books.filter { catalogViewModel.cartItems[$0.id] != nil }
        default:
            return []
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if cartBooks.isEmpty {
                    StatusView(message: "Tu carrito está vacío.", systemImage: "cart")
                } else {
                    List(cartBooks) { book in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text(book.formattedPrice)
                                    .bold()
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("Cantidad: \(catalogViewModel.cartItems[book.id] ?? 0)")
                                Button("Eliminar") {
                                    catalogViewModel.removeFromCart(book: book)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    .listStyle(.plain)

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text(cartViewModel.totalPriceText(for: cartBooks))
                                .font(.title2)
                                .bold()
                        }
                        Spacer()
                        Button("Pagar") {
                            // Placeholder action
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
            }
            .navigationTitle("Carrito")
        }
    }
}
