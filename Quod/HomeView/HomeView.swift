import SwiftUI

// Cor personalizada com inicializador único
extension Color {
    init(hexColor hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                
                // Título e Subtítulo
                VStack(spacing: 12) {
                    Text("QuOD")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hexColor: 0x7F38FF))

                    Text("Assegure o seu Amanhã, Hoje.")
                        .font(.subheadline)
                        .fontDesign(.monospaced)
                        .foregroundColor(Color(hexColor: 0x493e70))
                }

                // Botão "Iniciar"
                NavigationLink(destination: ContentView()) {
                    Text("Iniciar")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 48)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(hexColor: 0x7F38FF))
                                .shadow(radius: 10, x: 0, y: 10)
                        )
                        .scaleEffect(1.1)
                        .padding(.top, 40)
                }
            }
            .padding()
            .navigationTitle("") // Remover título da barra de navegação para limpeza
            .navigationBarHidden(true) // Esconder a barra de navegação para não distrair
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
