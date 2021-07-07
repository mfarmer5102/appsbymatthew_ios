//
//  SkillsView.swift
//  abm-ios
//
//  Created by Matthew Farmer on 7/6/21.
//

import Foundation
import SwiftUI

struct SkillsView: View {
    
    @State var isServerResponded = false
    @State var skills = [Skill]()
    
    var body: some View {
        NavigationView {
            if isServerResponded {
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
                .navigationBarTitle("Skills")
            } else {
                ProgressView()
                .onAppear() {
                    getSkillsData()
                }
                .navigationBarTitle("Skills")
            }

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
                    self.isServerResponded = true
                }
            case .failure(_):
                print("FAILED")
            }
//            case .failure(let error):
//            print(error.localizedDescription)
        }
    }
}
