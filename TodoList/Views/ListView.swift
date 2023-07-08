import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    var navigationBarTitle : String = "There are no items!"
    @EnvironmentObject private var tabSelection: TabSelection
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .navigationTitle(navigationBarTitle)
                    .transition(AnyTransition.opacity.animation(.easeIn))
                //noItemsView'a geri dönerken bir animasyon
            }
            else{
                ZStack {
                    TabView(selection: $tabSelection.selectedTab) {
                        FullList()
                            .tabItem {
                                Image(systemName: "list.bullet" )
                                Text("List")
                            }
                            .tag(0)
                        StatisticsView()
                            .tabItem {
                                Image(systemName: "chart.bar.fill")
                                Text("İstatistiklerim")
                            }
                            .tag(1)
                        SettingsView()
                            .tabItem {
                                Image(systemName: "gearshape")
                                Text("Ayarlar")
                            }
                            .tag(2)
                        
                        
                    }
                }.navigationBarHidden(true)
            }
        }
    }
    
    
}



struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            ListView()
        }
        .environmentObject(ListViewModel())
        .environmentObject(ScoreViewModel())
        
        
    }
}


