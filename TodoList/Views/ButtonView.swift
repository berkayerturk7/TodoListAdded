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
                                Circle()
                                    .foregroundColor(.blue)
                                    .frame(width: 90, height: 90)
                                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.blue.opacity(0.7), radius: animate ? 30 : 5, x: 0, y: animate ? 50 : 2)
                                
                                Text("Start Day")
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
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.red)
                                    .frame(width: 90, height: 90)
                                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.red.opacity(0.7), radius: animate ? 30 : 5, x: 0, y: animate ? 50 : 2)
                                
                                Text("See Schedule")
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
                        Spacer()
                        Button(action: {
                            // Yeşil butona tıklandığında yapılacak işlemler
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.green)
                                    .frame(width: 90, height: 90)
                                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.green.opacity(0.7), radius: animate ? 30 : 5, x: 0, y: animate ? 50 : 2)
                                
                                Text("Complete Day")
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
