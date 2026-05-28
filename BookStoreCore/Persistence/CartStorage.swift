import Foundation

public protocol CartStorage {

    func loadCartItems() -> [String: Int]

    func saveCartItems(_ items: [String: Int])

}
