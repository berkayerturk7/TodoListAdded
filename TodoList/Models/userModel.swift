import Foundation

struct UserModel: Identifiable,Codable {
    
    let id: String
    let username: String
    let sleepingTime: Date
    
    init(id: String = UUID().uuidString, username: String, sleepingTime: Date) {
        self.id = id
        self.username = username
        self.sleepingTime = sleepingTime
    
    }
    
}
