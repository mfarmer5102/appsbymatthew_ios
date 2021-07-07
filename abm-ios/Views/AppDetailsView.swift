//
//  AppDetailsView.swift
//  abm-ios
//
//  Created by Matthew Farmer on 7/6/21.
//

import Foundation
import SwiftUI

struct AppDetailsView: View {
    
    @State var isServerResponded = false
    @State var isRetrievedAppImage = false
    
    @State var appId = ""
    @State var appTitle = ""
    @State var appImage = UIImage()
    @State var appDescription = ""
    @State var associatedSkillCodes = [String]()
    @State var supportStatus = ""
    
    var body: some View {
        if isServerResponded && isRetrievedAppImage {
            VStack {
                Image(uiImage: appImage).resizable().frame(width: UIScreen.main.bounds.width, height: CGFloat(UIScreen.main.bounds.width * 0.6))
                Text(appDescription).fixedSize(horizontal: false, vertical: true).padding(.all)
                List {
                    // Status indicator
                    HStack {
                        Text("Status")
                        Spacer()
                        Text(supportStatus)
                    }
                    // Link to utilized skills
                    NavigationLink(destination: AssociatedSkillsView(skillCodes: associatedSkillCodes)) {
                        HStack {
                            Text("Skills Employed")
                            Spacer()
                            Text(String(associatedSkillCodes.count))
                        }
                    }
                }
            }
            .navigationTitle(appTitle)
        } else {
            ProgressView()
            .onAppear() {
                getAppDetailsData(applicationId: appId)
            }
            .navigationTitle(appTitle)
        }
    }
}

struct AssociatedSkillsView: View {
    
    @State var skillCodes = [String]()
    
    var body: some View {
        List(skillCodes, id: \.self) { skill in
            Text(skill)
        }.navigationTitle("Skills Used")
    }
}

extension AppDetailsView {
    
    func getAppDetailsData(applicationId: String) {
        Network().getAppDetails(appId: applicationId) { (result) in
            switch result {
            case .success(let appDetails):
                let thisApp = appDetails[0]
                DispatchQueue.main.async{
                    self.setImage(from: thisApp.image_url)
                    self.appTitle = thisApp.title
                    self.associatedSkillCodes = thisApp.associated_skill_codes
                    self.appDescription = thisApp.description
                    self.supportStatus = thisApp.support_status_code
                    self.isServerResponded = true
                }
            case .failure(_):
                print("FAILED")
            }
//            case .failure(let error):
//            print(error.localizedDescription)
        }
    }
    
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.appImage = image!
                self.isRetrievedAppImage = true
            }
        }
    }
    
}
