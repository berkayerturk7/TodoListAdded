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
    let emojis = ["😊", "🎉", "🌞", "🐶", "🍕"]
   
    
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
                }.pickerStyle(SegmentedPickerStyle())
                
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                    
                })
                
                
            }
            .padding(14)
        }
        .navigationTitle("Add an item 🖊️ ")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
       
        if textIsAppropriate() {
           listViewModel.items.removeAll { $0.id == itemToBeEdited.id }
           listViewModel.addItem(title: textFieldText, startTime: selectedStartTime, endTime: selectedEndTime, emoji: selectedEmoji)
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
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
        
    }
    
}


struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(itemToBeEdited: ItemModel.init(title: "", isCompleted: false, startTime: Date(), endTime: Date(), emoji: ""))
    }
}
