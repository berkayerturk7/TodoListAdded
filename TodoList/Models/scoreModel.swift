import Foundation

struct ScoreModel: Identifiable, Codable {
    
    let id: String
    let dateScore: Date
    let totalTasks: Int
    let doneTasks: Int
    
    init(id: String = UUID().uuidString, dateScore: Date, totalTasks: Int, doneTasks: Int) {
        
        self.id = id
        self.dateScore = dateScore
        self.totalTasks = totalTasks
        self.doneTasks = doneTasks
        
    }
    
}
