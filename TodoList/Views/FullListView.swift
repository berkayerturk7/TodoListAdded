import SwiftUI
import AVKit


struct FullList: View {
    
    @EnvironmentObject var scoreViewModel: ScoreViewModel
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var selectedItem: ItemModel? = nil
    @State private var isShowingAlert = false
    @EnvironmentObject var tabSelection: TabSelection
    @State private var selectedIndex = 1 // tomorrow
    
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    let structB = StructB()
    @State private var isShowingSheet = false
    @State private var isAnimating = false
    
    var soundManager = SoundManager()
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            VStack(spacing: 0) {
                LogoView()
                Picker(selection: $selectedIndex, label: Text("Tarih")) {
                    Text(getTodayDate()).tag(0)
                    Text(getTomorrowDate()).tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Text("I am planning for \(selectedIndex == 0 ? getTodayDate() : getTomorrowDate())")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .cornerRadius(8)
                    .background(Color.secondaryAccentColor)
                
                List {
                    
                    ForEach(listViewModel.items) { item in //arrayin her bir elemanı = item
                        ListRowView(item: item)
                            .onTapGesture { // bir hücreye tıkladığımızda
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                                SoundManager.instance.playSound()
                                
                            }
                            .swipeActions(edge: .leading) {
                                Button(action: {
                                    selectedItem = item
                                }) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                            }
                        
                    }
                    
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                    
                }
                
                
                .onAppear(perform: structB.decValue)
                .listStyle(PlainListStyle())
                .background(
                    Group {
                        if selectedItem != nil {
                            NavigationLink(
                                destination: EditItemView(itemToBeEdited: selectedItem!),
                                isActive: Binding(
                                    get: { selectedItem != nil },
                                    set: { isActive in
                                        if !isActive {
                                            selectedItem = nil
                                        }
                                    }
                                ),
                                label: EmptyView.init
                            )
                        }
                        
                    }
                )
                .alert(isPresented: $isShowingAlert) {
                    Alert(
                        title: Text("Günü tamamlamak istediğinize emin misiniz?"),
                        message: Text("Bu işlem geri alınamaz"),
                        primaryButton: .cancel(Text("İptal")),
                        secondaryButton: .destructive(Text("Tamamla")) {
                            // Tamamla butonuna tıklandığında yapılacak işlemler
                            
                            scoreViewModel.scores.append(ScoreModel(dateScore: selectedIndex == 0 ? getTodayDate() : getTomorrowDate(), totalTasks: listViewModel.getCountOfItems(), doneTasks: listViewModel.getCountCompletedItems()))
                            scoreViewModel.saveScores()
                            
                            
                            print("saved")
                            tabSelection.selectedTab = 1
                            //listViewModel.items.removeAll()
                            
                            
                            
                        }
                    )
                }
            }.onAppear {
                isAnimating = true
            }
            if GlobalData.shared.value == 0 {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            // İlk butona tıklandığında yapılacak işlemler
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.blue)
                                    .frame(width: 90, height: 90)
                                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.blue.opacity(0.7), radius: animate ? 30 : 5, x: 0, y: animate ? 50 : 2)
                                
                                Text("Start Day 🏁")
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 90)
                                    .lineLimit(2)
                            }
                        }
                        Spacer()
                        Button(action: {
                            // Kırmızı butona tıklandığında yapılacak işlemler
                            isShowingSheet = true
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.red)
                                    .frame(width: 90, height: 90)
                                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.red.opacity(0.7), radius: animate ? 30 : 5, x: 0, y: animate ? 50 : 2)
                                
                                Text("Add Task ➕")
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 90)
                                    .lineLimit(2)
                            }
                        }
                        .offset(y: -10)
                        .sheet(isPresented: $isShowingSheet) {
                            AddView()
                        }
                        Spacer()
                        Button(action: {
                            // Yeşil butona tıklandığında yapılacak işlemler
                            isShowingAlert = true
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.green)
                                    .frame(width: 90, height: 90)
                                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.green.opacity(0.7), radius: animate ? 30 : 5, x: 0, y: animate ? 50 : 2)
                                
                                HStack {
                                    Text("Complete Day ✅")
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .frame(width: 90)
                                        .lineLimit(2)
                                    
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, 16)
                }
            }
            //
        }.onAppear(perform: addAnimation)
    }
    
    
    // 3lü buton animasyonu
    func addAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                animate.toggle()
            }
        }
    }
    
    
    // Picker için bugün ve yarın fonksiyonları
    func getTodayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let todayDate = Date()
        return dateFormatter.string(from: todayDate)
    }
    
    func getTomorrowDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) {
            return dateFormatter.string(from: tomorrowDate)
        } else {
            return ""
        }
    }
    
    
    
    
    
    
    struct FullListView_Previews: PreviewProvider {
        static var previews: some View {
            FullList().environmentObject(ListViewModel())
        }
    }
}
