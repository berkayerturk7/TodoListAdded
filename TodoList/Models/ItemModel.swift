import Foundation

//Immutable Struct -> Tum struct degiskenleri let. Sadece updateCompletion fonksiyonu gunceli dondurebilir

struct ItemModel: Identifiable,Codable {
    
    let id: String
    let title: String
    let isCompleted: Bool
    
    // initiliaze edebiliriz default id ile veya idSiz.
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel { // daireyi tersine cevirme
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
    
}

