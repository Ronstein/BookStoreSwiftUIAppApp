import Foundation

public struct CartUseCase {

    private let storage: CartStorage

    public init(
        storage: CartStorage = UserDefaultsCartStorage()
    ) {
        self.storage = storage
    }

    public func loadCartItems() -> [String: Int] {
        storage.loadCartItems()
    }

    public func updateCartItems(
        _ items: [String: Int]
    ) {
        storage.saveCartItems(items)
    }

    public func addBook(
        _ book: Book,
        currentItems: [String: Int]
    ) -> [String: Int] {

        var updated = currentItems

        updated[book.id] =
            (updated[book.id] ?? 0) + 1

        updateCartItems(updated)

        return updated
    }

    public func removeBook(
        _ book: Book,
        currentItems: [String: Int]
    ) -> [String: Int] {

        var updated = currentItems

        if let quantity = updated[book.id],
           quantity > 1 {

            updated[book.id] = quantity - 1

        } else {

            updated.removeValue(forKey: book.id)
        }

        updateCartItems(updated)

        return updated
    }
}
