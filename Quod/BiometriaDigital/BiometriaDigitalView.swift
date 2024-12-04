import SwiftUI

struct BiometriaDigitalView: View {
    @State private var isProcessing: Bool = false
    @State private var progress: CGFloat = 0.0
    @State private var isSuccess: Bool? = nil // Resultado da validação

    var body: some View {
        VStack(spacing: 20) {
            Text("Biometria Digital")
                .font(.system(size: 24, weight: .bold, design: .default))
                .padding(.top)

            Text("Posicione seu dedo no sensor para simular a captura.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(Color.gray.opacity(0.2))
                    .frame(width: 200, height: 200)

                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.blue, .green]),
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: 200, height: 200)
                    .animation(.linear(duration: isProcessing ? 3.0 : 0.0), value: progress)

                if isProcessing {
                    Text("Capturando...")
                        .font(.headline)
                        .foregroundColor(.blue)
                } else if let success = isSuccess {
                    Text(success ? "Validado!" : "Falha!")
                        .font(.headline)
                        .foregroundColor(success ? .green : .red)
                } else {
                    Text("Toque para iniciar")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            if !isProcessing {
                Button(action: startFingerprintSimulation) {
                    Text("Iniciar Captura")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            } else {
                Button(action: cancelFingerprintSimulation) {
                    Text("Cancelar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }

    private func startFingerprintSimulation() {
        isProcessing = true
        progress = 0.0
        isSuccess = nil

        withAnimation {
            progress = 1.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Simula o tempo de captura
            isProcessing = false
            progress = 0.0
            isSuccess = Bool.random() // Randomiza sucesso ou falha
        }
    }

    private func cancelFingerprintSimulation() {
        isProcessing = false
        progress = 0.0
        isSuccess = nil
    }
}


struct BiometriaDigitalView_Previews: PreviewProvider {
    static var previews: some View {
        BiometriaDigitalView()
    }
}
