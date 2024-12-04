import SwiftUI
struct ContentView: View {
    @State private var isBiometricAuthenticationSuccessful = false

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                // Título
                Text("Simulação de Autenticação")
                    .font(.system(size: 24, weight: .heavy, design: .rounded))
                    .foregroundColor(Color(hexColor: 0x7f38ff)) // Usando o novo nome para cor
                    .padding(.bottom, 20)

                // Descrição
                Text("Escolha uma das opções abaixo para simular o fluxo de autenticação.")
                    .font(.system(size: 16, design: .monospaced))
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)

                // Lista de links
                Group {
                    AuthOptionButton(title: "SIM SWAP", destination: SimSwapView())
                    AuthOptionButton(title: "Biometria Facial", destination: BiometriaFacialView())
                    AuthOptionButton(title: "Biometria Digital", destination: BiometriaDigitalView())
                    AuthOptionButton(title: "Documentoscopia", destination: DocumentoscopiaView())
                    AuthOptionButton(title: "Score Antifraude", destination: ScoreAntifraudeView())
                    AuthOptionButton(title: "Autenticação Cadastral", destination: AutenticacaoCadastralView())
                }
                .padding(.top, 10)
            }
            .padding()
            .navigationTitle("Fluxos de Autenticação")
        }
    }
}

struct AuthOptionButton<Destination: View>: View {
    let title: String
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .font(.system(size: 16, design: .monospaced))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hexColor: 0x7f38ff)) // Usando o novo nome para cor
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
