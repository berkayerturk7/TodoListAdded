import SwiftUI


struct TimeLineView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    let calendar = Calendar.current // Calendar instance to work with dates
    
    var body: some View {
        VStack {
            Text("Appropriate Ranges")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                
            
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    ForEach(emptyTimeSlots(), id: \.self) { timeSlot in
                        TimeSlotView(startTime: timeSlot.startTime, endTime: timeSlot.endTime)
                    }
                }
                .padding(.horizontal, 20)
                .accentColor(Color.secondaryAccentColor)
                
            }
            
            Spacer()
        }
    }
    
    func emptyTimeSlots() -> [TimeSlot] {
        let sortedItems = listViewModel.items.sorted { $0.startTime < $1.startTime }
        var emptySlots: [TimeSlot] = []
        
        var previousEndTime = calendar.startOfDay(for: Date())
        
        for item in sortedItems {
            if item.startTime > previousEndTime {
                let slotDuration = calendar.dateComponents([.minute], from: previousEndTime, to: item.startTime)
                if slotDuration.minute ?? 0 >= 30 {
                    let emptySlot = TimeSlot(startTime: previousEndTime, endTime: item.startTime)
                    emptySlots.append(emptySlot)
                }
            }
            previousEndTime = item.endTime
        }
        
        let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: previousEndTime)!
        
        if previousEndTime < endOfDay {
            let slotDuration = calendar.dateComponents([.minute], from: previousEndTime, to: endOfDay)
            if slotDuration.minute ?? 0 >= 30 {
                let emptySlot = TimeSlot(startTime: previousEndTime, endTime: endOfDay)
                emptySlots.append(emptySlot)
            }
        }
        
        return emptySlots
    }
    
}

struct TimeSlot: Identifiable,Hashable {
    let id = UUID()
    var startTime: Date
    var endTime: Date
}

struct TimeSlotView: View {
    let startTime: Date
    let endTime: Date
    
    var body: some View {
        VStack {
            Text("\(formatDate(startTime)) - \(formatDate(endTime))")
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity)
                .background(Color.secondaryAccentColor)
                .cornerRadius(8)
                
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" // Customize date format as needed
        return dateFormatter.string(from: date)
    }
}



struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimeLineView().environmentObject(ListViewModel())
            FullList().environmentObject(ListViewModel())
        }
        
    }
}
