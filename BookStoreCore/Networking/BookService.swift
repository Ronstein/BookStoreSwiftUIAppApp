import Foundation

public protocol BookService: Sendable {

    func fetchBooks() async throws -> [Book]

}
