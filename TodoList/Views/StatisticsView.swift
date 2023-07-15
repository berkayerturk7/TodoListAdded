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
                                Text("Date: \(score.dateScore)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("Done Tasks: \(score.doneTasks)")
                                Text("Total Tasks: \(score.totalTasks)")
                                    .font(.headline)
                                
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
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
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                        .fontWeight(.bold)
                                    Text("/")
                                        .font(.title3)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    Text("\(score.totalTasks)")
                                        .font(.title2)
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                        .fontWeight(.bold)
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                .listStyle(GroupedListStyle())
            .navigationBarTitle("İstatistiklerim")
            
            .navigationBarItems(trailing:ShareLinkView())
            .onAppear {
                scoreViewModel.getScore()
            }
        }
    }
}


struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        let scoreViewModel = ScoreViewModel()
        scoreViewModel.scores = [
            ScoreModel(dateScore: "", totalTasks: 10, doneTasks: 5),
            ScoreModel(dateScore: "", totalTasks: 8, doneTasks: 3)
        ]
        
        return NavigationView {
            StatisticsView()
                .environmentObject(scoreViewModel)
        }
    }
}

// cmd opt enter preview
