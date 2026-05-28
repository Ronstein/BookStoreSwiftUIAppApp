import Foundation

public struct FetchBooksUseCase {

    private let service: BookService

    public init(
        service: BookService = DefaultBookService()
    ) {
        self.service = service
    }

    public func execute() async throws -> [Book] {
        try await service.fetchBooks()
    }
}
