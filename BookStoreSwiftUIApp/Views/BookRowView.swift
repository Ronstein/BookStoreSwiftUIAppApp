import SwiftUI
import BookStoreCore

struct BookRowView: View {

    let book: Book
    let isFavorite: Bool
    let onFavoriteToggle: () -> Void

    var body: some View {

        HStack(alignment: .top, spacing: 16) {

            BookCoverView(url: book.coverImageURL)
                .frame(width: 90, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 3)

            VStack(alignment: .leading, spacing: 10) {

                HStack(alignment: .top) {

                    VStack(alignment: .leading, spacing: 6) {

                        Text(book.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .lineLimit(2)

                        Text(book.author)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)

                        Text("Publicado \(book.publishYear)")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }

                    Spacer()

                    Button(action: onFavoriteToggle) {

                        Image(
                            systemName:
                                isFavorite
                                ? "heart.fill"
                                : "heart"
                        )
                        .font(.title3)
                        .foregroundStyle(
                            isFavorite
                            ? .pink
                            : .secondary
                        )
                    }
                    .buttonStyle(.plain)
                }

                Spacer(minLength: 8)

                Text(book.formattedPrice)
                    .font(.title3)
                    .fontWeight(.bold)
            }

            Spacer()
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 6,
                    x: 0,
                    y: 3
                )
        )
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
