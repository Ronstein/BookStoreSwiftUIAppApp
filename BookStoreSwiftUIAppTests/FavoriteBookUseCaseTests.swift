import Testing

@testable import BookStoreSwiftUIApp
import BookStoreCore

struct FavoriteBookUseCaseTests {

    @Test
    func toggleFavoriteAddsBook() {

        let storage =
            MockFavoriteStorage()

        let useCase =
            FavoriteBookUseCase(
                storage: storage
            )

        let result =
            useCase.toggleFavorite(
                id: "1",
                currentFavorites: []
            )

        #expect(
            result.contains("1")
        )
    }

    @Test
    func toggleFavoriteRemovesBook() {

        let storage =
            MockFavoriteStorage()

        let useCase =
            FavoriteBookUseCase(
                storage: storage
            )

        let result =
            useCase.toggleFavorite(
                id: "1",
                currentFavorites: ["1"]
            )

        #expect(
            !result.contains("1")
        )
    }
}
