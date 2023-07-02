import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    var navigationBarTitle : String = "There are no items!"
    @State private var tabSelection = 0
    
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
                    TabView {
                        FullList()
                            .tabItem {
                                Image(systemName: "list.bullet" )
                                Text("List")
                            }
                        StatisticsView()
                            .tabItem {
                                Image(systemName: "chart.bar.fill")
                                Text("İstatistiklerim")
                            }
                        SettingsView()
                            .tabItem {
                                Image(systemName: "gearshape")
                                Text("Ayarlar")
                            }
                        
                        
                    }
                }.navigationBarHidden(true)
            }
        }
    }
    
    
}



struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            // ListView()
            FullList()
        }
        .environmentObject(ListViewModel())
        
    }
}


struct FullList: View {
    
    @EnvironmentObject var scoreViewModel: ScoreViewModel
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var selectedItem: ItemModel? = nil
    @State private var isShowingAlert = false
    @State private var tabSelection: Int? //bu
    
    
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(listViewModel.items) { item in //arrayin her bir elemanı = item
                    ListRowView(item: item)
                        .onTapGesture { // bir hücreye tıkladığımızda
                            withAnimation(.linear) {
                                listViewModel.updateItem(item: item)
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button(action: {
                                selectedItem = item
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                    
                }
                
                .onDelete(perform: listViewModel.deleteItem)
                .onMove(perform: listViewModel.moveItem)
                
            }
            .background(
                Group {
                    if selectedItem != nil {
                        NavigationLink(
                            destination: EditItemView(itemToBeEdited: selectedItem!),
                            isActive: Binding(
                                get: { selectedItem != nil },
                                set: { isActive in
                                    if !isActive {
                                        selectedItem = nil
                                    }
                                }
                            ),
                            label: EmptyView.init
                        )
                    }
                    
                }
            )
            .navigationTitle("Tomorrow Todo List 📒")
            .navigationBarItems(
                leading: EditButton(),
                trailing: HStack {
                    
                    NavigationLink(destination: AddView()) {
                        Image(systemName: "plus")
                    }
                    
                    Button(action: {
                        isShowingAlert = true
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                    }
                    .buttonStyle(PlainButtonStyle()) // NavigationLink özelliğini kaldırır
                    
                }
            )
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Günü tamamlamak istediğinize emin misiniz?"),
                    message: Text("Bu işlem geri alınamaz"),
                    primaryButton: .cancel(Text("İptal")),
                    secondaryButton: .destructive(Text("Tamamla")) {
                        // Tamamla butonuna tıklandığında yapılacak işlemler
                        
                        scoreViewModel.scores.append(ScoreModel(dateScore: Date(), totalTasks: listViewModel.getCountOfItems(), doneTasks: listViewModel.getCountCompletedItems()))
                        scoreViewModel.saveScores()
                        print("saved")
                        
                        
                        
                        
                    }
                )
            }
            
        }
    }
    
}
