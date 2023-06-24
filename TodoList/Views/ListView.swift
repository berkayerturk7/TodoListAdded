//
//  ListView.swift
//  TodoList
//
//  vievmodel : seperates view from data logic
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    var navigationBarTitle : String = "There are no items!"
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .navigationTitle(navigationBarTitle)
                    .transition(AnyTransition.opacity.animation(.easeIn))
                    //noItemsView'a geri dönerken bir animasyon
            }
            else{
                FullList()
                    .listStyle(PlainListStyle())
                    .navigationTitle("Todo List 📒")
                    .navigationBarItems(
                            leading: EditButton(),
                            trailing: NavigationLink("Add", destination: AddView()))
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
       
    }
}


struct FullList: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        List {
            ForEach(listViewModel.items) { item in //arrayin her bir elemanı = item
                ListRowView(item: item)
                    .onTapGesture { // bir hücreye tıkladığımızda
                        withAnimation(.linear) {
                            listViewModel.updateItem(item: item)
                        }
                    }
            }
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
        }
    }
}
