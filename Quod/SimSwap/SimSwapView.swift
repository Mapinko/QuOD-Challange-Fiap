import SwiftUI

struct SimSwapView: View {
    @Environment(\.dismiss) var dismiss // Ambiente para controlar a navegação
    @State private var phoneNumber: String = ""
    @State private var resultMessage: String? = nil
    @State private var isLoading: Bool = false
    @State private var isValidPhoneNumber: Bool = true // Para validação de número

    var body: some View {
        VStack(spacing: 24) {

            // Título
            Text("SIM SWAP")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(Color(hexColor: 0x7F38FF))
                .padding(.top)

            // Descrição do fluxo
            Text("Insira o número de telefone para verificar se houve troca recente de chip.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            // Campo de telefone
            TextField("Número de Telefone", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .onChange(of: phoneNumber) { newValue in
                    // Valida número de telefone (exemplo básico)
                    isValidPhoneNumber = newValue.count == 11 // Assumindo número com 11 caracteres
                }

            // Indicador de erro se número de telefone for inválido
            if !isValidPhoneNumber && !phoneNumber.isEmpty {
                Text("Número inválido. Por favor, insira um número válido.")
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.horizontal, 24)
            }

            // Indicador de carregamento ou botão
            if isLoading {
                ProgressView("Verificando...")
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(hexColor: 0x7F38FF)))
                    .padding()
            } else {
                Button(action: checkSimSwap) {
                    Text("Verificar")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isValidPhoneNumber ? Color(hexColor: 0x7F38FF) : Color.gray)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .disabled(!isValidPhoneNumber) // Desabilita o botão se o número for inválido
                }
                .padding(.horizontal, 24)
            }

            // Resultado da verificação
            if let message = resultMessage {
                Text(message)
                    .font(.headline)
                    .foregroundColor(message.contains("detectado") ? .red : .green)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 24)
            }

            Spacer()

            // Botão de voltar
            Button(action: {
                dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left.circle.fill")
                        .foregroundColor(Color(hexColor: 0x7F38FF))
                    Text("Voltar")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hexColor: 0x7F38FF))
                }
                .padding(.bottom, 24)
            }
        }
        .padding()
        .navigationBarHidden(true) // Esconder a barra de navegação para uma tela limpa
    }

    private func checkSimSwap() {
        // Simulação de chamada de API
        isLoading = true
        resultMessage = nil

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Simula um tempo de resposta
            isLoading = false

            // Simulação de resultado (alternando entre positivo e negativo)
            if Bool.random() {
                resultMessage = "SIM SWAP detectado para o número \(phoneNumber)."
            } else {
                resultMessage = "Nenhuma troca de chip detectada para o número \(phoneNumber)."
            }
        }
    }
}

struct SimSwapView_Previews: PreviewProvider {
    static var previews: some View {
        SimSwapView()
    }
}
