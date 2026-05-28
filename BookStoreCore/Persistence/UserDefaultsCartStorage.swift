import Foundation

public struct UserDefaultsCartStorage: CartStorage {

    private let key = "BookStore.CartItems"

    public init() {}

    public func loadCartItems() -> [String: Int] {

        UserDefaults.standard.dictionary(
            forKey: key
        ) as? [String: Int] ?? [:]
    }

    public func saveCartItems(_ items: [String: Int]) {

        UserDefaults.standard.set(
            items,
            forKey: key
        )
    }
}
