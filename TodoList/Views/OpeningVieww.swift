
import SwiftUI

struct OpeningVieww: View {
    @State var username: String = ""
    @State private var selectedDate = Date()
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    @EnvironmentObject var userViewModel: UserViewModel
    @State var isActive = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("BackgroundGradientStart"), Color("BackgroundGradientEnd")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Merhaba,")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Tomorrow Planner'a Hoşgeldin")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                TextField("İsmin", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                Text("Uyku saatini bizimle paylaşır mısın?")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: .hourAndMinute
                )
                .labelsHidden()
                .datePickerStyle(.wheel)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.bottom, 30)
                
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
                
                Spacer()
            }
            .padding()
        }
        .onAppear(perform: addAnimation)
    }
    
    func addAnimation() {
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



struct OpeningVieww_Previews: PreviewProvider {
    static var previews: some View {
        OpeningVieww()
    }
}
