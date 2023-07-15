//
//  EditItemView.swift
//  TodoList
//
//  Created by Berkay Ertürk on 25.06.2023.
//

import SwiftUI

struct EditItemView: View {
    
    var itemToBeEdited: ItemModel
    
    
    init(itemToBeEdited: ItemModel) {
            self.itemToBeEdited = itemToBeEdited
            _textFieldText = State(initialValue: itemToBeEdited.title)
            _selectedEmoji = State(initialValue: itemToBeEdited.emoji)
            _selectedStartTime = State(initialValue: itemToBeEdited.startTime)
            _selectedEndTime = State(initialValue: itemToBeEdited.endTime)
            structA.incValue()
        }
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State var selectedStartTime = Date()
    @State var selectedEndTime = Date()
    private let calendar = Calendar.current
    @State private var selectedEmoji = "🎉"
    let emojis = ["▪︎", "🍳", "💪", "👯", "🍕", "📚"]
    let structA = StructA()
    
    @State private var importanceLevel = 3
    
    var body: some View {
        
        
        ScrollView {
            VStack {
                TextField("", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                DatePicker(
                    "Start Time",
                    selection: $selectedStartTime,
                    in: ...selectedEndTime, // İkinci DatePicker'ın seçilen saatine kadar olan aralık
                    displayedComponents: .hourAndMinute
                )
                
                
                DatePicker(
                    "End Time",
                    selection: $selectedEndTime,
                    in: selectedStartTime..., // İlk DatePicker'ın seçilen saatinden sonraki aralık
                    displayedComponents: .hourAndMinute
                )
                Picker("Select an Emoji", selection: $selectedEmoji) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
                            .font(.largeTitle)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedEmoji) { _ in
                        updateTextFieldText()
                    }
                
                Text("Importance Level").bold()
                ExclamationRatingView(rating: $importanceLevel)
                
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                    
                })
                
                TimeLineView()
            }
            .padding(14)
        }
        .navigationTitle("Add an item 🖊️ ")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func updateTextFieldText() {
       if selectedEmoji == "🍳" {
           textFieldText = "Nice breakfast time!"
       }
       else if selectedEmoji == "💪" {
           textFieldText = "Training time!"
       }
       else if selectedEmoji == "🍕" {
           textFieldText = "Mealtime"
       }
       else if selectedEmoji == "👯" {
           textFieldText = "Date with "
       }
       else if selectedEmoji == "📚" {
            textFieldText = "Study"
            withAnimation {
                importanceLevel  = 5
            }
        }
       else {
           textFieldText = "" // Diğer emojiler için metin alanını temizleme
       }
   }
    
    
    
    func saveButtonPressed() {
        if textIsAppropriate() {
           listViewModel.items.removeAll { $0.id == itemToBeEdited.id }
            listViewModel.addItem(title: textFieldText, startTime: selectedStartTime, endTime: selectedEndTime, emoji: selectedEmoji, userDayPoint: importanceLevel)
            print("x")

            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new todo item must be at least 3 characters long!! 😨"
            showAlert.toggle() // alert goster, kullanıcı kapatınca kapansın
            return false
        }
        else if !slotIsAppropriate(selectedStartTime: selectedStartTime, selectedEndTime: selectedEndTime) {
            alertTitle = "There is another event in your todo list in that range!! 🙌"
            showAlert.toggle() // alert goster, kullanıcı kapatınca kapansın
            return false
        }
        else {
            return true
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
    
    func slotIsAppropriate(selectedStartTime: Date, selectedEndTime: Date) -> Bool {
        let selectedSlot = TimeSlot(startTime: selectedStartTime, endTime: selectedEndTime)
        let emptySlots = emptyTimeSlots()
        
        for emptySlot in emptySlots {
            print(emptySlot)
           if selectedSlot.startTime >= emptySlot.startTime && selectedSlot.endTime <= emptySlot.endTime {
                return true
            }
        }
        
        return false
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
        
    }
    
}


struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(itemToBeEdited: ItemModel.init(title: "", isCompleted: false, startTime: Date(), endTime: Date(), emoji: "", userItemPoint: 0))
    }
}
