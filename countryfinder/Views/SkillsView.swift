import SwiftUI

struct SkillsView: View {
    
    @State var skills = [Skill]()
    
    var body: some View {
        NavigationView {
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
        }
    }
}

extension SkillsView {
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
}
