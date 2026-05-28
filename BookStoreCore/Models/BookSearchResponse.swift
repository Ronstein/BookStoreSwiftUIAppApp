import Foundation

public struct BookSearchResponse: Decodable {

    public let docs: [OpenLibraryBook]

    public init(docs: [OpenLibraryBook]) {
        self.docs = docs
    }
}

public struct OpenLibraryBook: Decodable {

    public let key: String?
    public let title: String?
    public let author_name: [String]?
    public let first_sentence: [String]?
    public let cover_i: Int?
    public let publish_year: [Int]?

    public init(
        key: String?,
        title: String?,
        author_name: [String]?,
        first_sentence: [String]?,
        cover_i: Int?,
        publish_year: [Int]?
    ) {
        self.key = key
        self.title = title
        self.author_name = author_name
        self.first_sentence = first_sentence
        self.cover_i = cover_i
        self.publish_year = publish_year
    }

    public func toDomainModel() -> Book {

        let id = key ?? UUID().uuidString
        let title = self.title ?? "Untitled"
        let author = author_name?.first ?? "Unknown author"
        
        let description =
                first_sentence?.first
                ?? "\(title) is a book written by \(author)."

        let coverImageURL = cover_i.flatMap {
            URL(string: "https://covers.openlibrary.org/b/id/\($0)-L.jpg")
        }

        let year = publish_year?
            .compactMap { String($0) }
            .first ?? "N/A"

        let price =
            Decimal(Double((cover_i ?? 0) % 40 + 10))
            + Decimal(0.99)

        return Book(
            id: id,
            title: title,
            author: author,
            price: price,
            description: description,
            coverImageURL: coverImageURL,
            publishYear: year
        )
    }
}
