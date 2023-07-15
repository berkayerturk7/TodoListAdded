import SwiftUI

struct StartDayButton: View {
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        TabView {
            ZStack(alignment: .top) {
                NavigationView {
                    List(1...10, id: \.self) { index in
                        Text("List Item \(index)")
                    }
                    .navigationBarTitle("List")
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            // İlk butona tıklandığında yapılacak işlemler
                        }) {
                            ZStack {
                                Circle()
                                    .trim(from: 0, to: animate ? 0.6 : 0)
                                    .stroke(secondaryAccentColor, lineWidth: 4)
                                    .frame(width: 120, height: 120)
                                    .rotationEffect(.degrees(animate ? 360 : 0))
                                    .animation(.easeInOut(duration: 2.0).repeatForever(), value: animate)
                                
                                Image(systemName: "🏁")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                                
                                Text("Start Day")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, 16)
                }
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("List")
            }
            
            Text("Second Tab")
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Second")
                }
        }
        .onAppear(perform: addAnimation)
    }
    
    func addAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                animate.toggle()
            }
        }
    }
}

struct StartDayButton_Previews: PreviewProvider {
    static var previews: some View {
        StartDayButton()
    }
}
