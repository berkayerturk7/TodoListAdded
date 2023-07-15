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
    // Add Task Button
    @State private var animateAddTask: Bool = false
    @State private var scale: CGFloat = 1.3
    
    
    
    
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
            }

            .onAppear {
                isAnimating = true
            }
            if GlobalData.shared.value == 0 {
                VStack {
                    Spacer()
                    VStack(spacing: -6) {
                       
                        Button(action: {
                            // İlk butona tıklandığında yapılacak işlemler
                        }) {
                            /*ZStack {
                                Circle()
                                    .foregroundColor(.secondaryAccentColor)
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
                            }*/
                        }
                       
                        Button(action: {
                            // Kırmızı butona tıklandığında yapılacak işlemler
                            isShowingSheet = true
                        }) {
                            // MARK: Add Task
                            ZStack {
                                Circle()
                                    .foregroundColor(.secondaryAccentColor)
                                    .frame(width: 65, height: 65)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.red.opacity(0.4), lineWidth: 5)
                                            .blur(radius: 4)
                                            .offset(x: 2, y: 2)
                                            .mask(Circle().fill(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .topTrailing, endPoint: .bottomLeading)))
                                            .shadow(color: Color.red.opacity(0.4), radius: 8, x: 0, y: 0)
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(Color.red.opacity(0.2), lineWidth: 8)
                                            .blur(radius: 4)
                                            .offset(x: -2, y: -2)
                                            .mask(Circle().fill(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                            .shadow(color: Color.red.opacity(0.4), radius: 8, x: 0, y: 0)
                                    )
                                    .shadow(color: Color.red.opacity(0.4), radius: 8, x: 0, y: 0) // Dış çevreye gölge ekle
                                Text("+")
                                    .font(.system(size: 55, weight: .light))
                                    .foregroundColor(.white)
                                    .offset(y: -3) // + simgesini yukarı doğru hafifçe kaydır
                            }
                        }
                        
                        .scaleEffect(scale)
                        .animation(Animation.easeInOut(duration: 1.1).repeatForever(autoreverses: true), value: scale)
                        .onAppear(perform: addAddTaskAnimation)
                        .offset(y: -10)
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $isShowingSheet) {
                            AddView()
                        }
                        
                        Button(action: {
                            // Yeşil butona tıklandığında yapılacak işlemler
                            isShowingAlert = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(secondaryAccentColor)
                                    .frame(width: 170, height: 30)
                                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.green.opacity(0.7), radius: animate ? 30 : 5, x: 0, y: animate ? 50 : 2)
                                
                                HStack {
                                    Text("Complete Day")
                                        .font(.system(size: 14, weight: .bold)) // Font boyutunu düzenle
                                        .foregroundColor(.white)
                                        .padding()
                                        //.frame(maxWidth: .infinity) // İçeriği butona sığdırmak için maksimum genişlik ayarla
                                }
                            }

                        }
                        
                    }
                    
                    .padding(.bottom, 16)
                }
            }
            //
        }
    }
    
    func addAddTaskAnimation() {
        withAnimation(Animation.easeInOut(duration: 1.1).repeatForever(autoreverses: true)) {
            scale = 0.95
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
