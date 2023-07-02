

import SwiftUI

struct OpeningView: View {
    
    @State var username: String = ""
    @State private var selectedDate = Date()
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    @EnvironmentObject var userViewModel: UserViewModel
    @State var isActive = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Merhaba \(username),")
                .font(.largeTitle)
            Text("Tomorrow Planner'a Hoşgeldin")
            TextField("İsmin", text: $username)
            
            Text("Uyku saatini bizimle paylaşır mısın? (Ertesi günü planlaman için sana bu saatte bildirim göndereceğiz.) ")
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: .hourAndMinute // Sadece saat ve dakika gösterilecek
            )
            .labelsHidden() // Etiketleri gizleyerek daha temiz bir görünüm elde edebilirsiniz
            .datePickerStyle(.wheel) // Tercihinize bağlı olarak farklı stil seçenekleri mevcut
            
            Button(action: {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.hour, .minute], from: selectedDate)
                let hour = components.hour ?? 0
                let minute = components.minute ?? 0
                if userViewModel.users.count == 0 {
                    userViewModel.addUser(username: username, sleepingTime: selectedDate)
                    userViewModel.saveUser()
                }
                else {
                    userViewModel.users.removeAll()
                    userViewModel.addUser(username: username, sleepingTime: selectedDate)
                    userViewModel.saveUser()
                    
                }
                // Hedef görünüme manuel olarak geçiş yap
                isActive = true
            }) {
                Text("Next ⏩")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(animate ? secondaryAccentColor : Color.accentColor)
                    .cornerRadius(10)
            }
            .padding(.horizontal, animate ? 30 : 50)
            .shadow(
                color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                radius: animate ? 30 : 10,
                x: 0,
                y: animate ? 50 : 30)
            .scaleEffect(animate ? 1.1 : 1.0)
            .offset(y: animate ? -7 : 0)
            .background(
                NavigationLink(
                    destination: ListView(),
                    isActive: $isActive,
                    label: EmptyView.init
                )
            )
        }
    }
  
    func addAnimation() {
       // guard !animate else {return} // animate
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}
    struct OpeningView_Previews: PreviewProvider {
        static var previews: some View {
            OpeningView()
        }
    }
