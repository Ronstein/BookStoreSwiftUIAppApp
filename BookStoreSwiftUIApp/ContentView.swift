//
//  ContentView.swift
//  BookStoreSwiftUIApp
//
//  Created by Rodrigo Ignacio on 26-05-26.
//

import SwiftUI

struct ContentView: View {
    @State private var catalogViewModel = CatalogViewModel()
    @State private var cartViewModel = CartViewModel()
    
    private var totalCartItems: Int {
            catalogViewModel.cartItems.values.reduce(0, +)
    }

    var body: some View {
        TabView {
            CatalogScreen(viewModel: catalogViewModel)
                .tabItem {
                    Label("Catálogo", systemImage: "books.vertical")
                }

            FavoritesScreen(catalogViewModel: catalogViewModel)
                .tabItem {
                    Label("Favoritos", systemImage: "heart")
                }

            CartScreen(catalogViewModel: catalogViewModel, cartViewModel: cartViewModel)
                .tabItem {
                    Label("Carrito", systemImage: "cart")
                }
                .badge(totalCartItems)
        }
    }
}

#Preview {
    ContentView()
}
