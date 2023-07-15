import SwiftUI

struct ExclamationRatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "exclamationmark.circle.fill" : "exclamationmark.circle")
                    .font(.system(size: 30))
                    .foregroundColor(.secondaryAccentColor)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}

struct ContentView: View {
    @State private var importanceLevel = 3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Importance Level").bold()
            ExclamationRatingView(rating: $importanceLevel)
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
            
            ContentView()
        
        
        
    }
}
