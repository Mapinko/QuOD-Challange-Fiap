import SwiftUI

struct ScoreAntifraudeView: View {
    @State private var cpf: String = ""
    @State private var isProcessing: Bool = false
    @State private var score: Int? = nil // Resultado do score

    var body: some View {
        VStack(spacing: 20) {
            Text("Score Antifraude")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .padding(.top)

            Text("Digite o CPF para calcular o score antifraude.")
                .font(.body)
                .fontDesign(.monospaced)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            TextField("Digite o CPF", text: $cpf)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .fontDesign(.monospaced)
                .padding(.horizontal)
                .onChange(of: cpf) { newValue in
                    cpf = String(newValue.prefix(11)) // Limita a entrada a 11 dígitos
                }

            if !isProcessing {
                Button(action: calculateScore) {
                    Text("Calcular Score")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isCPFValid ? Color(hex: 0x493e70) : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .fontDesign(.monospaced)
                        .disabled(!isCPFValid)
                }
                .padding(.horizontal)
            } else {
                ProgressView("Calculando...")
                    .padding()
            }

            if let scoreValue = score {
                VStack(spacing: 10) {
                    Text("Score Calculado:")
                        .font(.headline)

                    Text("\(scoreValue)")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(scoreColor(for: scoreValue))

                    Text(scoreFeedback(for: scoreValue))
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }

            Spacer()
        }
        .padding()
    }

    // Valida se o CPF possui exatamente 11 caracteres
    private var isCPFValid: Bool {
        cpf.count == 11 && Int(cpf) != nil
    }

    // Calcula o score de maneira simulada
    private func calculateScore() {
        isProcessing = true
        score = nil

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Simula tempo de processamento
            isProcessing = false
            score = Int.random(in: 1...1000) // Gera um score aleatório
        }
    }

    // Retorna uma cor baseada no score
    private func scoreColor(for score: Int) -> Color {
        switch score {
        case 800...1000:
            return .green
        case 500..<800:
            return .yellow
        default:
            return .red
        }
    }

    // Retorna um feedback textual baseado no score
    private func scoreFeedback(for score: Int) -> String {
        switch score {
        case 800...1000:
            return "Baixo risco de fraude."
        case 500..<800:
            return "Risco moderado de fraude."
        default:
            return "Alto risco de fraude!"
        }
    }
}



struct ScoreAntifraudeView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreAntifraudeView()
    }
}
