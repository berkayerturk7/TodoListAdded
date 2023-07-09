import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Ana Görünüm")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                // Diğer içerikler burada yer alabilir
            }
            .navigationBarTitle("Ana Görünüm", displayMode: .inline)
        }
        .overlay(TabbarOverlay(), alignment: .bottom) // Tabbar overlay'ı ekle
    }
}

struct TabbarOverlay: View {
    @State private var selectedIndex = 0
    
    private let tabbarItems = [
        TabbarItem(icon: "house", title: "Home"),
        TabbarItem(icon: "bell", title: "Notifications"),
        TabbarItem(icon: "person", title: "Profile")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabbarItems.indices, id: \.self) { index in
                TabbarItemView(tabbarItem: tabbarItems[index], isSelected: selectedIndex == index)
                    .onTapGesture {
                        selectedIndex = index
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemBackground))
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -2)
        .padding(.horizontal)
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
    }
}

struct TabbarItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
}

struct TabbarItemView: View {
    let tabbarItem: TabbarItem
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: tabbarItem.icon)
                .font(.system(size: 24, weight: isSelected ? .bold : .regular))
                .foregroundColor(isSelected ? .blue : .gray)
            
            Text(tabbarItem.title)
                .font(.caption)
                .foregroundColor(isSelected ? .blue : .gray)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            
           ContentView()

        
    }
}
