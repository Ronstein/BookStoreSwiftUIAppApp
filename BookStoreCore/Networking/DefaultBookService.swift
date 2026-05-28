import Foundation

public struct DefaultBookService: BookService {

    private let session: URLSession
    private let decoder: JSONDecoder

    public init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }

    public func fetchBooks() async throws -> [Book] {

           let urlString =

               "https://openlibrary.org/search.json?q=fiction&limit=50"

           guard let url = URL(string: urlString) else {

               throw BookError.invalidURL

           }

           do {

               let (data, response) =

                   try await session.data(from: url)

               guard

                   let httpResponse = response as? HTTPURLResponse,

                   (200...299).contains(httpResponse.statusCode)

               else {

                   throw BookError.invalidResponse

               }

               let bookResponse = try decoder.decode(

                   BookSearchResponse.self,

                   from: data

               )

               return bookResponse.docs.map {

                   $0.toDomainModel()

               }

           } catch let error as BookError {

               throw error

           } catch {

               throw BookError.networkError(error)

           }

       }
}

public enum BookError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL del servicio es inválida."
        case .invalidResponse:
            return "Respuesta inválida del servidor."
        case .decodingError(let error):
            return "No se pudo decodificar el resultado: \(error.localizedDescription)"
        case .networkError(let error):
            return "Error de red: \(error.localizedDescription)"
        }
    }
}
