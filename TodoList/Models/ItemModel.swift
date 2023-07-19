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
    
    let importanceLevel: Int
    
    var rangeTime: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: startTime, to: endTime)

        if let minutes = components.minute {
            return minutes
        } else {
            return 0
        }
    }
    
    // initiliaze edebiliriz default id ile veya idSiz.
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, startTime: Date, endTime: Date, emoji: String, userItemPoint: Int, importanceLevel: Int) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.startTime = startTime
        self.endTime = endTime
        self.emoji = emoji
        self.userItemPoint = userItemPoint
        
        self.importanceLevel = importanceLevel
    }
    
    func updateCompletion() -> ItemModel { // daireyi tersine cevirme
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, startTime: startTime, endTime: endTime, emoji: emoji, userItemPoint: userItemPoint, importanceLevel: importanceLevel)
    }
    
    
}

