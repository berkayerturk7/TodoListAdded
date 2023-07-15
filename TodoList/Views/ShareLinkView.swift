import SwiftUI

@MainActor
struct ShareLinkView: View {
    
    @EnvironmentObject var scoreViewModel: ScoreViewModel
    
    var body: some View {
        ShareLink("Export PDF", item: render())
    }
    
    func render() -> URL {
        // 1: Render Hello World with some modifiers
        let renderer = ImageRenderer(content:
                                        
        ForEach(scoreViewModel.scores.reversed()) { score in
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date: \(score.dateScore)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Total Tasks")
                        .font(.headline)
                    Text("Done Tasks")
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .trim(from: 0, to: CGFloat(score.doneTasks) / CGFloat(score.totalTasks))
                        .stroke(Color.secondaryAccentColor, lineWidth: 20)
                        .rotationEffect(Angle(degrees: -90))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                        )
                        .foregroundColor(.clear)
                    
                    HStack {
                        Text("\(score.doneTasks)")
                            .font(.title3)
                        
                            .fontWeight(.bold)
                        Text("/")
                            .font(.title3)
                        
                        Text("\(score.totalTasks)")
                            .font(.title2)
                        
                            .fontWeight(.bold)
                    }
                }
                
            }
            
        }
)
        
        // 2: Save it to our documents directory
        let url = URL.documentsDirectory.appending(path: "output.pdf")
        
        // 3: Start the rendering process
        renderer.render { size, context in
            // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            // 5: Create the CGContext for our PDF pages
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }
            
            // 6: Start a new PDF page
            pdf.beginPDFPage(nil)
            
            // 7: Render the SwiftUI view data onto the page
            context(pdf)
            
            // 8: End the page and close the file
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
}
struct ShareLinkView_Previews: PreviewProvider {
    static var previews: some View {
        let scoreViewModel = ScoreViewModel()
        scoreViewModel.scores = [
            ScoreModel(dateScore: "", totalTasks: 10, doneTasks: 5),
            ScoreModel(dateScore: "", totalTasks: 8, doneTasks: 3)
        ]
        
        return NavigationView {
            ShareLinkView()
                .environmentObject(scoreViewModel)
        }
    }
}

