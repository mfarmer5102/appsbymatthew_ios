import SwiftUI

struct ApplicationsView: View {
    
    @State var applications = [Application]()
    
    var body: some View {
        NavigationView {
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
            .navigationTitle("Applications")
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
