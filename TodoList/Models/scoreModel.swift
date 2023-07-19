import Foundation

struct ScoreModel: Identifiable, Codable, Hashable {
    
    let id: String
    let dateScore: String
    let totalTasks: Int
    let doneTasks: Int
    
    let titleOfTask: String
    let completedOfTask: Bool
  
    let importanceOfTask: String
    let rangeTime: String
    
    
    init(id: String = UUID().uuidString, dateScore: String, totalTasks: Int, doneTasks: Int, titleOfTask: String, completedOfTask: Bool, importanceOfTask: String, rangeTime: String) {
        
        self.id = id
        self.dateScore = dateScore
        self.totalTasks = totalTasks
        self.doneTasks = doneTasks
        
        self.titleOfTask = titleOfTask
        self.completedOfTask = completedOfTask
        
        self.importanceOfTask = importanceOfTask
        
        self.rangeTime = rangeTime
        
    }
    
}
