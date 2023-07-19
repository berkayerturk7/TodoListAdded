import Foundation
import SwiftUI
/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 
 */


class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            // arrayde her değişiklik olduğunda  -> yani deleting, moving vsvs hepsinde
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        
        /*let newItems = [
            
            ItemModel(title: "This is the first title!", isCompleted: false),
            ItemModel(title: "This is the first second!", isCompleted: true),
            ItemModel(title: "This is the first third!", isCompleted: false)
            
        ]
        items.append(contentsOf: newItems) */
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
        
        
    }
    
    func deleteItem(indexSet: IndexSet) {
            items.remove(atOffsets: indexSet)
        }
    
    func moveItem(from:IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String, startTime: Date, endTime:Date, emoji:String, userDayPoint: Int, importanceLevel: Int) {
        let newItem = ItemModel(title: title, isCompleted: false, startTime: startTime, endTime: endTime, emoji: emoji, userItemPoint: userDayPoint, importanceLevel: importanceLevel) // default false
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        
        if let index = items.firstIndex(where: { $0.id == item.id}){
           
            items[index] = item.updateCompletion()
        }
        
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func getCountOfItems() -> Int {
        let count = items.count
        return count
    }
    
    func getCountCompletedItems() -> Int {
        let completedItems = items.filter { $0.isCompleted }
        return completedItems.count
    }
    
    // sonra ekledim
    func getAllItemTitlesAndCompletionStatus() -> [(title: String, isCompleted: Bool, importanceLevel: Int, rangeTime:Int)] {
        return items.map { (title: $0.title, isCompleted: $0.isCompleted, importanceLevel: $0.importanceLevel, rangeTime: $0.rangeTime) }
    }

    
}
