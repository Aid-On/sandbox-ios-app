import SwiftUI

struct ContentView: View {
    @State private var environmentName: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image(systemName: "app.badge")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                VStack(spacing: 8) {
                    Text("AidOn Sandbox")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("SwiftUI Test Application")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if !environmentName.isEmpty {
                    Text("Environment: \(environmentName)")
                        .font(.caption)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(.tertiary.opacity(0.5))
                        .clipShape(Capsule())
                }
                
                Button("Test Button") {
                    print("Button tapped in AidOn Sandbox!")
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
            .navigationTitle("AidOn Sandbox")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            environmentName = Environment.properties(forKey: "ENVIRONMENT_NAME")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}