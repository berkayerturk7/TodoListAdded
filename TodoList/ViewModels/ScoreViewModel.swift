import Foundation

class ScoreViewModel: ObservableObject {
    
    @Published var scores: [ScoreModel] = []
        
        
    let scoresKey: String = "score_list"
    
    init() {
        getScore()
    }
    
    func getScore() {
        
        guard
            let data = UserDefaults.standard.data(forKey: scoresKey),
            let savedScores = try? JSONDecoder().decode([ScoreModel].self, from: data)
        else { return }
        
        self.scores = savedScores
        
    }
    
    func deleteScore(indexSet: IndexSet) {
        scores.remove(atOffsets: indexSet)
    }
    
    func moveScore(from: IndexSet, to: Int) {
        scores.move(fromOffsets: from, toOffset: to)
    }
    
    func saveScores() {
        if let encodedData = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(encodedData, forKey: scoresKey)
        }
    }
    
    
    
}
