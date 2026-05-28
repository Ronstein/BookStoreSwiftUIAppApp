import SwiftUI

struct BookCoverView: View {
    let url: URL?

    var body: some View {
        Group {
            if let url = url {
                
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        placeholder
                    @unknown default:
                        placeholder
                    }
                }
         
            } else {
                placeholder
            }
        }
        .frame(height: 220)
        .clipped()
        .cornerRadius(12)
    }

    private var placeholder: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.secondary.opacity(0.1))
            Image(systemName: "book")
                .font(.largeTitle)
                .foregroundColor(.secondary)
        }
    }
}
