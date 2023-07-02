import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var scoreViewModel: ScoreViewModel
    var nowTime : Date = Date()
    @State private var totalTasks = 0
    @State private var doneTasks = 0
    
    var body: some View {
                NavigationView {
                    List {
                        ForEach(scoreViewModel.scores) { score in
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Total Tasks: \(score.totalTasks)")
                                        .font(.headline)
                                    Text("Done Tasks: \(score.doneTasks)")
                                    
                                    Text("Now Time: \(formatTime(date: nowTime))")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                            .padding(.vertical, 5)
                                
                                Button(action: {
                                    // Butona tıklanınca çalışacak kodlar
                                    // Edit user info
                                }) {
                                    Image(systemName: "pencil.circle.fill")
                                        .foregroundColor(.secondary)
                                        .font(.title)
                                }
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle("İstatistiklerim")
                }
                .onAppear {
                    scoreViewModel.getScore()
                }
            }

    
    func formatTime(date: Date) -> String {
         let formatter = DateFormatter()
         formatter.dateFormat = "HH:mm" // Kullanmak istediğiniz saat formatını belirleyin
         return formatter.string(from: date)
     }
   }

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
           // ListView()
        StatisticsView()
        }
        .environmentObject(ScoreViewModel())
        
    }
}
// cmd opt enter preview
