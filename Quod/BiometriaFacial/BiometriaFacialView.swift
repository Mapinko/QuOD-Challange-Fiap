import SwiftUI
import LocalAuthentication

struct BiometriaFacialView: View {
    @State private var isProcessing: Bool = false
    @State private var isSuccess: Bool? = nil // Resultado da validação
    @State private var errorMessage: String? = nil // Mensagem de erro, se necessário

    var body: some View {
        VStack(spacing: 20) {
            Text("Biometria Facial")
                .font(.system(size: 24, weight: .bold, design: .default))
                .padding(.top)

            Text("Alinhe seu rosto no centro do quadro para simular a captura ou use o Face ID.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 300, height: 300)
                    .overlay(
                        Text("Seu rosto aqui")
                            .font(.headline)
                            .foregroundColor(.gray)
                    )

                if isProcessing {
                    ProgressView("Capturando...")
                        .frame(width: 300, height: 300)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                }
            }

            if let success = isSuccess {
                Text(success ? "Biometria validada com sucesso!" : "Falha na validação biométrica.")
                    .font(.headline)
                    .foregroundColor(success ? .green : .red)
                    .padding(.top, 10)
            }

            if let error = errorMessage {
                Text(error)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }

            Spacer()

            if !isProcessing {
                Button(action: startBiometricSimulation) {
                    Text("Iniciar Captura")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .onTapGesture {
                    authenticateWithBiometrics()
                }
            } else {
                Button(action: cancelBiometricSimulation) {
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

    private func startBiometricSimulation() {
        isProcessing = true
        isSuccess = nil
        errorMessage = nil

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Simula o tempo de captura
            isProcessing = false
            isSuccess = Bool.random() // Randomiza sucesso ou falha
        }
    }

    private func cancelBiometricSimulation() {
        isProcessing = false
        isSuccess = nil
        errorMessage = nil
    }

    private func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?

        // Verifica se o dispositivo tem suporte para biometria (Face ID ou Touch ID)
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Por favor, autentique-se para continuar") { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Sucesso na autenticação biométrica
                        self.isSuccess = true
                    } else {
                        // Falha na autenticação
                        self.isSuccess = false
                        self.errorMessage = authenticationError?.localizedDescription
                    }
                    self.isProcessing = false
                }
            }
        } else {
            // Dispositivo não tem biometria configurada
            errorMessage = "Biometria não configurada ou disponível no dispositivo."
            self.isProcessing = false
        }
    }
}

struct BiometriaFacialView_Previews: PreviewProvider {
    static var previews: some View {
        BiometriaFacialView()
    }
}
