import SwiftUI
import BookStoreCore

struct CartScreen: View {
    @State private var catalogViewModel: CatalogViewModel

    init(catalogViewModel: CatalogViewModel) {
        self._catalogViewModel = State(initialValue: catalogViewModel)
    }

    var cartBooks: [Book] {
        switch catalogViewModel.state {
        case .loaded(let books):
            return books.filter { catalogViewModel.cartItems[$0.id] != nil }
        default:
            return []
        }
    }

    var totalPrice: Decimal {
        cartBooks.reduce(into: Decimal(0)) { total, book in
            let quantity = Decimal(catalogViewModel.cartItems[book.id] ?? 0)
            total += book.price * quantity
        }
    }

    var totalPriceText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"

        return formatter.string(from: totalPrice as NSNumber) ?? "$0.00"
    }

    var body: some View {
        NavigationStack {
            VStack {
                if cartBooks.isEmpty {
                    StatusView(
                        message: "Tu carrito está vacío.",
                        systemImage: "cart"
                    )
                } else {
                    List(cartBooks) { book in
                        HStack(spacing: 16) {

                            BookCoverView(url: book.coverImageURL)
                                .frame(width: 60, height: 90)
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading, spacing: 6) {
                                Text(book.title)
                                    .font(.headline)
                                    .lineLimit(2)

                                Text(book.author)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)

                                Text(book.formattedPrice)
                                    .font(.subheadline)
                                    .bold()
                            }

                            Spacer()

                            VStack(spacing: 8) {
                                Text("x\(catalogViewModel.cartItems[book.id] ?? 0)")
                                    .font(.headline)

                                Button {
                                    catalogViewModel.removeFromCart(book: book)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .listStyle(.plain)

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text(totalPriceText)
                                .font(.title2)
                                .bold()
                        }

                        Spacer()

                        Button("Pagar") {

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
