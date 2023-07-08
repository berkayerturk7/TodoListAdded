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
    @StateObject var userViewModel: UserViewModel = UserViewModel()
    @StateObject var scoreViewModel: ScoreViewModel = ScoreViewModel()
    let tabSelection = TabSelection()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                OpeningView()
                
            }
          // entire app navigation view da olsun
            .environmentObject(listViewModel)
            .environmentObject(userViewModel)
            .environmentObject(scoreViewModel)
            .environmentObject(tabSelection)
          
        }
    }
}

