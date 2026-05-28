import Foundation
import BookStoreCore

@MainActor
@Observable
final class CartViewModel {

    var cartItems: [String: Int]

    private static let currencyFormatter: NumberFormatter = {

        let formatter = NumberFormatter()

        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 2

        return formatter
    }()

    init(
        cartItems: [String: Int] = [:]
    ) {
        self.cartItems = cartItems
    }

    func quantity(for book: Book) -> Int {

        cartItems[book.id] ?? 0
    }

    func totalPrice(
        for books: [Book]
    ) -> Decimal {

        books.reduce(into: Decimal(0)) { total, book in

            let quantity =
                Decimal(cartItems[book.id] ?? 0)

            total += book.price * quantity
        }
    }

    func totalPriceText(
        for books: [Book]
    ) -> String {

        Self.currencyFormatter.string(
            from: totalPrice(for: books) as NSNumber
        ) ?? "$0.00"
    }

    func cartBooks(
        from books: [Book]
    ) -> [Book] {

        books.filter {
            cartItems[$0.id] != nil
        }
    }
}
