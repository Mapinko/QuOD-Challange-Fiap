import SwiftUI

struct DocumentoscopiaView: View {
    @State private var isDocumentCaptured: Bool = false
    @State private var isFaceCaptured: Bool = false
    @State private var isProcessing: Bool = false
    @State private var validationResult: Bool? = nil // Resultado da validação

    var body: some View {
        VStack(spacing: 20) {
            Text("Documentoscopia")
                .font(.system(size: 24, weight: .bold, design: .default))
                .padding(.top)

            Text("Capture uma imagem do documento e sua face para validar a autenticidade.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            VStack(spacing: 15) {
                CaptureSection(
                    isCaptured: $isDocumentCaptured,
                    label: "Documento",
                    placeholderText: "Imagem do documento"
                )

                CaptureSection(
                    isCaptured: $isFaceCaptured,
                    label: "Face",
                    placeholderText: "Imagem da face"
                )
            }

            Spacer()

            if !isProcessing {
                Button(action: startValidation) {
                    Text("Validar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isDocumentCaptured && isFaceCaptured ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(!isDocumentCaptured || !isFaceCaptured)
                }
                .padding(.horizontal)
            } else {
                ProgressView("Validando...")
                    .padding()
            }

            if let result = validationResult {
                Text(result ? "Documento validado com sucesso!" : "Falha na validação do documento.")
                    .font(.headline)
                    .foregroundColor(result ? .green : .red)
                    .padding()
            }
        }
        .padding()
    }

    private func startValidation() {
        isProcessing = true
        validationResult = nil

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Simula o tempo de validação
            isProcessing = false
            validationResult = Bool.random() // Randomiza sucesso ou falha
        }
    }
}

struct CaptureSection: View {
    @Binding var isCaptured: Bool
    let label: String
    let placeholderText: String

    var body: some View {
        VStack(spacing: 10) {
            Text(label)
                .font(.headline)

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 150)
                    .overlay(
                        Text(isCaptured ? "\(label) capturado!" : placeholderText)
                            .font(.body)
                            .foregroundColor(isCaptured ? .green : .gray)
                    )

                if isCaptured {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .offset(x: -10, y: -10)
                }
            }

            Button(action: { isCaptured = true }) {
                Text(isCaptured ? "Capturado" : "Capturar \(label.lowercased())")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isCaptured ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }
}


struct DocumentoscopiaView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentoscopiaView()
    }
}
