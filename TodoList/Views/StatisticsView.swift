import SwiftUI
import Charts

struct StatisticsView: View {
    @EnvironmentObject var scoreViewModel: ScoreViewModel
    @State private var totalTasks = 0
    @State private var doneTasks = 0
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(scoreViewModel.scores.reversed()) { score in
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(score.dateScore)")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.secondary)
                            
                            
                            Text("Completed: ")
                                .foregroundColor(.secondaryAccentColor)
                                .bold()
                            
                            HStack {
                                Text(score.titleOfTask)
                                    .strikethrough()
                                Text(String(score.importanceOfTask))
                                
                                Text(String(score.rangeTime))
                            }
                            
                            
                            
                            Text(" ")
                            
                            ZStack {
                                Circle()
                                    .trim(from: 0, to: CGFloat(score.doneTasks) / CGFloat(score.totalTasks))
                                    .stroke(Color.secondaryAccentColor, lineWidth: 10)
                                    .rotationEffect(Angle(degrees: -90))
                                    .frame(width: 80, height: 80)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 10)
                                    )
                                    .foregroundColor(.clear)
                                
                                HStack {
                                    Text("\(score.doneTasks)")
                                        .font(.title3)
                                        .foregroundColor(.secondaryAccentColor)
                                    
                                    Text("/")
                                        .bold()
                                        .font(.title3)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    Text("\(score.totalTasks)")
                                        .bold()
                                        .font(.title3)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Rectangle()
                                        .frame(width: 8, height: 8)
                                        .foregroundColor(.secondaryAccentColor)
                                    Text("Done")
                                    
                                        .foregroundColor(.secondaryAccentColor)
                                }
                                HStack {
                                    Rectangle()
                                        .frame(width: 8, height: 8)
                                        .foregroundColor(.black)
                                    Text("Total")
                                        .bold()
                                }
                            }
                            
                        }
                        Spacer()
                        VStack(){
                            Text("Day Point: ")
                                .font(.title)
                            if countRangeOfTasksBigThan3(rangeOfTasks: score.rangeTime) {
                                    let calculatedDayPoint = calculateDayPoint(importanceOfTasks: score.importanceOfTask, rangeTime: score.rangeTime)
                                    let calculatedDayScore = calculateDayScore(dayPoint: calculatedDayPoint)
                                    //Text(calculatedDayPoint)
                                    Text(calculatedDayScore)
                                    .font(.title)
                                }
                            else {
                                Text("The day score will be visible when you complete at least 3 tasks during the day")
                                   
                            }
                            // 4800 - 100 ise 3660 - 76,25
                           
                            }

                            
                        
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("My Statistics")
            .navigationBarItems(trailing:ShareLinkView())
            .onAppear {
                scoreViewModel.getScore()
            }
        }
        
        
    }
    
    func calculateDayPoint(importanceOfTasks: String, rangeTime: String) -> String {
        var dayPoint = 0
        let linesForImportanceOfTasks = importanceOfTasks.components(separatedBy: "\n")
        let linesForRangeTime = rangeTime.components(separatedBy: "\n")
        var importances: [Int] = []
        var ranges: [Int] = []
        
        for line in linesForImportanceOfTasks {
            if let number = Int(line.trimmingCharacters(in: .whitespacesAndNewlines)) {
                importances.append(number)
            }
        }
        
        for line in linesForRangeTime {
            if let number = Int(line.trimmingCharacters(in: .whitespacesAndNewlines)) {
                ranges.append(number)
            }
        }
        
        for (importance, range) in zip(importances, ranges) {
            dayPoint += importance * range
        }
  
        return String(dayPoint)
    }
    
    // Day Score -> Kullanıcının o gün için 100 üzerinden aldığı score.
    func calculateDayScore(dayPoint: String) -> String {
        var dayScore = 0
        let dayPointInt = Int(dayPoint) ?? 0
        
        
        if dayPointInt >= 4800 {
            dayScore = 100
        }
        else if dayPointInt >= 4000 {
            dayScore = 90
     
        }
        else if dayPointInt >= 3500 {
            dayScore = 85
          
        }
        else if dayPointInt >= 3000 {
            dayScore = 80
           
        }
        
        return String(dayScore)
    }
    
    func countRangeOfTasksBigThan3(rangeOfTasks: String) -> Bool {
        let linesForRangeTime = rangeOfTasks.components(separatedBy: "\n")
        var ranges: [Int] = []
        
        for line in linesForRangeTime {
            if let number = Int(line.trimmingCharacters(in: .whitespacesAndNewlines)) {
                ranges.append(number)
            }
        }
        
        if ranges.count >= 3 {
            return true
        }
        else {
            return false
        }
        
    }
    
    
}


struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        let scoreViewModel = ScoreViewModel()
        scoreViewModel.scores = [
            ScoreModel(dateScore: "12.07.2023", totalTasks: 8, doneTasks: 6, titleOfTask: "title", completedOfTask: true, importanceOfTask: "3",rangeTime: "4"),
            ScoreModel(dateScore: "13.07.2023", totalTasks: 5, doneTasks: 2, titleOfTask: "title2", completedOfTask: false, importanceOfTask: "3",rangeTime: "9")
        ]
        
        return NavigationView {
            StatisticsView()
                .environmentObject(scoreViewModel)
        }
    }
}

// cmd opt enter preview
