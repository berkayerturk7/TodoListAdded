import SwiftUI

struct AddTaskButton: View {
    @State private var animateAddTask: Bool = false
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        Button(action: {
            // Buraya tıklandığında yapılacak işlemler
        }) {
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
                    .font(.system(size: 46, weight: .light))
                    .foregroundColor(.white)
                    .offset(y: -3) // + simgesini yukarı doğru hafifçe kaydır
            }
        }
        .scaleEffect(scale)
        .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: scale)
        .onAppear(perform: addAddTaskAnimation)
    }
    
    func addAddTaskAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
            scale = 0.95
        }
    }
}

struct AddTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskButton()
    }
}
