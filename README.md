# BookStoreSwiftUIApp

## Descripción

Esta aplicación simula una tienda de libros con catálogo, detalle de libro, carrito de compras y favoritos.
Se implementa con SwiftUI y un enfoque de MVVM / Clean Architecture, separando la lógica de negocio de la presentación.

## Cómo compilar y ejecutar

1. Abre el proyecto en Xcode:
   - `BookStoreSwiftUIApp.xcodeproj`

2. Selecciona el esquema `BookStoreSwiftUIApp`.
3. Ejecuta el proyecto en un simulador o dispositivo con `Cmd+R`.

### Usando Fastlane

Desde la raíz del proyecto:

```bash
bundle install
bundle exec fastlane tests
bundle exec fastlane build
```

- `fastlane tests`: ejecuta los tests de unidad usando `scan` en el esquema `BookStoreSwiftUIApp`.
- `fastlane build`: construye la app en el mismo esquema.

## Arquitectura

### Clean Architecture

El proyecto está dividido en dos capas principales:

- `BookStoreCore (XCFramework)`
  - `Models`: modelos de dominio y transformaciones desde la API.
  - `Networking`: la capa de datos remotos, con un servicio que consume OpenLibrary.
  - `Persistence`: abstrae el almacenamiento local.
  - `UseCases`: casos de uso que orquestan la lógica de negocio.

- `BookStoreSwiftUIApp`
  - `Views`: interfaces de usuario SwiftUI.
  - `ViewModels`: administra el estado, la lógica de interacción y los casos de uso.

Esta separación mantiene la lógica de negocio fuera de la UI y facilita pruebas y mantenimiento.

### MVVM

El patrón MVVM se aplica de la siguiente manera:

- `View`:
  - `CatalogScreen`
  - `BookDetailScreen`
  - `FavoritesScreen`
  - `CartScreen`

- `ViewModel`:
  - `CatalogViewModel`: carga libros, maneja estados (`idle`, `loading`, `loaded`, `error`), favoritos y carrito.
  - `CartViewModel`: calcula totales y presenta el precio formateado.
  - `FavoritesViewModel`: filtra libros favoritos (aunque la pantalla principal reutiliza `CatalogViewModel`).

- `Model` / `Domain`:
  - `Book`: entidad principal de dominio.
  - `BookSearchResponse` / `OpenLibraryBook`: estructuras de respuesta de API.

### Implementación de estados

La app usa `LoadingState<T>` para representar:

- `idle`
- `loading`
- `loaded(T)`
- `error(String)`

Esto permite a las vistas mostrar:

- pantalla de carga
- lista de libros
- vista vacía
- error

## Estructura de carpetas

- `BookStoreCore/`
  - `Models/`
    - `Book.swift`
    - `BookSearchResponse.swift`
  - `Networking/`
    - `BookService.swift`
    - `DefaultBookService.swift`
  - `Persistence/`
    - `CartStorage.swift`
    - `FavoriteStorage.swift`
    - `UserDefaultsCartStorage.swift`
    - `UserDefaultsFavoriteStorage.swift`
  - `UseCases/`
    - `CartUseCase.swift`
    - `FavoriteBookUseCase.swift`
    - `FetchBooksUseCase.swift`

- `BookStoreSwiftUIApp/`
  - `BookStoreSwiftUIAppApp.swift`
  - `ContentView.swift`
  - `Models/`
    - `LoadingState.swift`
  - `ViewModels/`
    - `CartViewModel.swift`
    - `CatalogViewModel.swift`
    - `FavoritesViewModel.swift`
  - `Views/`
    - `BookCoverView.swift`
    - `BookDetailScreen.swift`
    - `BookRowView.swift`
    - `CartScreen.swift`
    - `CatalogScreen.swift`
    - `FavoritesScreen.swift`
    - `StatusView.swift`

- `BookStoreSwiftUIAppTests/`
  - `BookStoreSwiftUIAppTests.swift`
  - `FavoriteBookUseCaseTests.swift`
  - `MockFavoriteStorage.swift`

- `fastlane/`
  - `Fastfile`

## API utilizada

La aplicación consume la API pública de OpenLibrary:

- `https://openlibrary.org/search.json?q=fiction&limit=50`

Los resultados se mapean a la entidad `Book` usando `OpenLibraryBook.toDomainModel()`, generando:

- `id`
- `title`
- `author`
- `description`
- `coverImageURL`
- `publishYear`
- `price` simulado

## Persistencia local

Se utiliza `UserDefaults` para persistir:

- favoritos: `UserDefaultsFavoriteStorage`
- carrito: `UserDefaultsCartStorage`

Esto permite que los favoritos y la cantidad del carrito sobrevivan entre sesiones.
