import SwiftUI

/*
 MVVM Arch
 Model - Data point
 View - UI
 ViewModel - Manages models for view
 */


@main
struct TodoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
          // entire app navigation view da olsun
            .environmentObject(listViewModel)
        }
    }
}

