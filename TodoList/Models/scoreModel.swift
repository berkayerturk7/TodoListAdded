import Foundation

struct ScoreModel: Identifiable, Codable, Hashable {
    
    let id: String
    let dateScore: String
    let totalTasks: Int
    let doneTasks: Int
    
    init(id: String = UUID().uuidString, dateScore: String, totalTasks: Int, doneTasks: Int) {
        
        self.id = id
        self.dateScore = dateScore
        self.totalTasks = totalTasks
        self.doneTasks = doneTasks
        
    }
    
}
