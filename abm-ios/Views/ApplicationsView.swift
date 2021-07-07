//
//  ApplicationsView.swift
//  abm-ios
//
//  Created by Matthew Farmer on 7/6/21.
//

import Foundation
import SwiftUI

struct ApplicationsView: View {
    
    @State var isServerResponded = false
    @State var applications = [Application]()
    
    var body: some View {
        NavigationView {
            if isServerResponded {
                List(applications, id: \.self) { application in
                    HStack() {
                        if application.is_featured {
                            Image(systemName: "star.fill")
                                .foregroundColor(.pink)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.pink)
                        }
                        NavigationLink(destination: AppDetailsView(appId: application._idFlat)) {
                            Text(application.title)                        }
                    }
                }
                .navigationTitle("Applications")
            } else {
                ProgressView()
                .onAppear() {
                    getApplicationsData()
                }
                .navigationTitle("Applications")
            }
        }
    }
}

extension ApplicationsView {
    func getApplicationsData() {
        Network().getApplications { (result) in
            switch result {
            case .success(let applications):
                DispatchQueue.main.async{
                    self.applications = applications
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
