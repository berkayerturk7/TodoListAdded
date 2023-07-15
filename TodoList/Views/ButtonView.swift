import SwiftUI

struct ButtonView: View {
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
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(secondaryAccentColor)
                                    .frame(width: 120, height: 50)
                                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : secondaryAccentColor.opacity(0.3), radius: animate ? 30 : 5, x: 0, y: animate ? 50 : 2)
                                
                                Text("Start Day")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(8)
                                    .frame(width: 100)
                                    .lineLimit(2)
                            }
                        }
                        Spacer()
                        Button(action: {
                            // Kırmızı butona tıklandığında yapılacak işlemler
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(secondaryAccentColor)
                                    .frame(width: 120, height: 50)
                                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : secondaryAccentColor.opacity(0.3), radius: animate ? 30 : 5, x: 0, y: animate ? 50 : 2)
                                
                                Text("See Schedule")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(8)
                                    .frame(width: 100)
                                    .lineLimit(2)
                            }
                        }
                        .offset(y: -10)
                        Spacer()
                        Button(action: {
                            // Yeşil butona tıklandığında yapılacak işlemler
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(secondaryAccentColor)
                                    .frame(width: 120, height: 50)
                                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : secondaryAccentColor.opacity(0.3), radius: animate ? 30 : 5, x: 0, y: animate ? 50 : 2)
                                
                                Text("Complete Day")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(8)
                                    .frame(width: 100)
                                    .lineLimit(2)
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
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                animate.toggle()
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
