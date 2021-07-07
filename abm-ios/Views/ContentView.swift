import SwiftUI

struct ContentView: View {
    
    @State var skills = [Skill]()
    
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            
            // Applications View
            HStack() {
                ApplicationsView()
            }
            .tabItem {
                Image(systemName: "tray.full")
                Text("Applications")
            }
            .tag(1)
            
            // Skills View
            HStack() {
                SkillsView()
            }
            .tabItem {
                Image(systemName: "bolt.horizontal")
                Text("Skills")
            }
            .tag(2)

        }.accentColor(.pink)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}

extension ContentView {
    
    // Functions specific to this view go here
    
}
