import Foundation

//Immutable Struct -> Tum struct degiskenleri let. Sadece updateCompletion fonksiyonu gunceli dondurebilir

struct ItemModel: Identifiable,Codable, Equatable {
    
    let id: String
    let title: String
    let isCompleted: Bool
    let startTime: Date
    let endTime: Date
    let emoji: String
    let userItemPoint: Int
    
    // initiliaze edebiliriz default id ile veya idSiz.
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, startTime: Date, endTime: Date, emoji: String, userItemPoint: Int) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.startTime = startTime
        self.endTime = endTime
        self.emoji = emoji
        self.userItemPoint = userItemPoint
    }
    
    func updateCompletion() -> ItemModel { // daireyi tersine cevirme
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, startTime: startTime, endTime: endTime, emoji: emoji, userItemPoint: userItemPoint)
    }
    
    
}

