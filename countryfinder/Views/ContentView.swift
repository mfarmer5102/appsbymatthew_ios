import SwiftUI

struct ContentView: View {
    
    @State var skills = [Skill]()
    @State var applications = [Application]()
    
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            
            // Applications Tab
            List(applications, id: \.self) { application in
                HStack() {
                    Text(application.title)
                    Spacer()
                    if application.is_featured {
                        Image(systemName: "star.fill")
                            .foregroundColor(.pink)
                    } else {
                        Image(systemName: "star")
                            .foregroundColor(.pink)
                    }
                }
            }
            .onAppear() {
                getApplicationsData()
            }
            .navigationBarTitle("Applications")
            .tabItem {
                Image(systemName: "tray.full")
                Text("Applications")
            }
            .tag(1)
            
            // Skills Tab
            List(skills, id: \.self) { skill in
                HStack() {
                    Text(skill.name)
                    Spacer()
                    if skill.is_proficient {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.yellow)
                    }
                }
            }
            .onAppear() {
                getSkillsData()
            }
            .navigationBarTitle("Skills")
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
    }
}

extension ContentView {
    func getSkillsData() {
        Network().getSkills { (result) in
            switch result {
            case .success(let skills):
                DispatchQueue.main.async{
                    self.skills = skills
                    print(self.skills)
                }
            case .failure(_):
                print("FAILED")
            }
//            case .failure(let error):
//            print(error.localizedDescription)
        }
    }
    func getApplicationsData() {
        Network().getApplications { (result) in
            switch result {
            case .success(let applications):
                DispatchQueue.main.async{
                    self.applications = applications
                    print(self.applications)
                }
            case .failure(_):
                print("FAILED")
            }
//            case .failure(let error):
//            print(error.localizedDescription)
        }
    }
}
