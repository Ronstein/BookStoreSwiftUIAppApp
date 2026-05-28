import Foundation

public struct Book: Identifiable, Equatable, Hashable {
    public let id: String
    public let title: String
    public let author: String
    public let price: Decimal
    public let description: String
    public let coverImageURL: URL?
    public let publishYear: String

    public var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: price as NSNumber) ?? "$0.00"
    }
    
    init(id: String, title: String, author: String, price: Decimal, description: String, coverImageURL: URL?, publishYear: String) {
        self.id = id
        self.title = title
        self.author = author
        self.price = price
        self.description = description
        self.coverImageURL = coverImageURL
        self.publishYear = publishYear
    }
}
