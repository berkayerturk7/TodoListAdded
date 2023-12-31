import SwiftUI

struct LogoView: View {
    @State private var isAnimating = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        VStack(spacing: 10) {
            Circle()
                .fill(Color.secondaryAccentColor)
                .frame(width: 80, height: 80)
                .overlay(
                    VStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 20, height: 6)
                            .cornerRadius(3)
                            .offset(y: isAnimating ? -10 : 0)
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 20, height: 6)
                            .cornerRadius(3)
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 20, height: 6)
                            .cornerRadius(3)
                            .offset(y: isAnimating ? 10 : 0)
                    }
                )
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                        isAnimating = true
                    }
                }
            
            HStack(spacing: 0) {
                Text("TO")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.secondaryAccentColor)
                Text("DO")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Text("MORROW")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.secondaryAccentColor)
                
            }.padding(.bottom, 10)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
