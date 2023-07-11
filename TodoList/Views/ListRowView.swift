
import SwiftUI


struct ListRowView: View {
    let item: ItemModel
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }
    
    var body: some View {
        let calendar = Calendar.current
        let startTimeString = dateFormatter.string(from: item.startTime)
        let endTimeString = dateFormatter.string(from: item.endTime)
        
        HStack {
            Text(item.emoji)
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text(item.title)
                    .foregroundColor(item.isCompleted ? .green : .secondaryAccentColor)
                    .font(.title2)
                    .padding(2)
                HStack {
                    Text("\(startTimeString) - \(endTimeString)")
                        .font(.caption)
                        .foregroundColor(item.isCompleted ? .green : .secondaryAccentColor)
                }
                .font(.title3)
                .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 20))
                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                .cornerRadius(10)
                Spacer()
            }
            Spacer()
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .secondaryAccentColor)
                .font(.largeTitle)
        }
    }
}


struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        ListRowView(item: ItemModel(title: "title", isCompleted: true, startTime: Date(), endTime: Date(), emoji: ""))
    }
}

