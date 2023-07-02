
import SwiftUI


struct ListRowView: View {
    let item: ItemModel
    
    
    var body: some View {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: item.startTime)
        let hour = components.hour
        let minute = components.minute
        
        let components2 = calendar.dateComponents([.hour, .minute], from: item.endTime)
        let hour2 = components2.hour
        let minute2 = components2.minute
        
        HStack {
            Text(item.emoji)
                .font(.largeTitle)
            VStack(alignment: .leading) {
                
                
                Text(item.title)
                    .foregroundColor(item.isCompleted ? .green : .red)
                    .font(.title2)
                    .padding(-2)
                HStack {
                    
                    Text("\(hour ?? 0) : \(minute ?? 0) - \(hour2 ?? 0) : \(minute2 ?? 0) ")
                        .foregroundColor(item.isCompleted ? .green : .red)
                    
                }
                .font(.title3)
                .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 20))
                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                .cornerRadius(10)
                
                Spacer()
                
            }
            Spacer()
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
                .font(.largeTitle)
        }
        
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        ListRowView(item: ItemModel(title: "title", isCompleted: true, startTime: Date(), endTime: Date(), emoji: ""))
    }
}

