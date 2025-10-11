import SwiftUI

@main
struct TemplateApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print("App launched successfully")
                }
        }
    }
}