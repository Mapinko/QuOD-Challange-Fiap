import SwiftUI

struct AutenticacaoCadastralView: View {
    @State private var nome = ""
    @State private var cpf = ""
    @State private var endereco = ""
    @State private var telefone = ""

    @State private var erros: [String: String] = [:]
    @State private var isFormValid = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações Pessoais")) {
                    // Nome
                    customTextField("Nome Completo", text: $nome, erroKey: "nome")
                    
                    // CPF
                    customTextField("CPF", text: $cpf, erroKey: "cpf")
                    
                    // Endereço
                    customTextField("Endereço", text: $endereco, erroKey: "endereco")
                    
                    // Telefone
                    customTextField("Telefone", text: $telefone, erroKey: "telefone")
                        .onChange(of: telefone) { newValue in
                            telefone = formatarTelefone(newValue)
                        }
                }

                // Botão de envio
                Button(action: {
                    validarTodosCampos()
                }) {
                    Text("Validar")
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .padding()
                        .background(isFormValid ? Color(hex: 0x7f38ff) : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(!isFormValid)
                }
                .padding()
            }
            .navigationTitle("Autenticação Cadastral")
            .font(.system(size: 18, weight: .semibold))
        }
    }

    // Função para validar todos os campos de uma vez
    private func validarTodosCampos() {
        validarCampo(nome, erroKey: "nome")
        validarCampo(cpf, erroKey: "cpf")
        validarCampo(endereco, erroKey: "endereco")
        validarCampo(telefone, erroKey: "telefone")
        isFormValid = erros.isEmpty
    }

    // Função para validar campos
    func validarCampo(_ valor: String, erroKey: String) {
        switch erroKey {
        case "nome":
            erros[erroKey] = valor.isEmpty ? "Nome não pode estar vazio" : nil
        case "cpf":
            erros[erroKey] = isValidCPF(valor) ? nil : "CPF inválido"
        case "endereco":
            erros[erroKey] = valor.isEmpty ? "Endereço não pode estar vazio" : nil
        case "telefone":
            erros[erroKey] = telefone.count >= 10 ? nil : "Telefone deve ter ao menos 10 dígitos"
        default:
            break
        }
    }

    // Validação de CPF (algoritmo de verificação de CPF)
    private func isValidCPF(_ cpf: String) -> Bool {
        // Adicionar validação do CPF (algoritmo de cálculo dos dígitos verificadores)
        return cpf.count == 11 && Int(cpf) != nil
    }

    // Função para formatar o telefone
    func formatarTelefone(_ valor: String) -> String {
        var telefoneFormatado = valor.filter { $0.isNumber }
        
        if telefoneFormatado.count > 10 {
            telefoneFormatado.insert(")", at: telefoneFormatado.index(telefoneFormatado.startIndex, offsetBy: 2))
            telefoneFormatado.insert("(", at: telefoneFormatado.startIndex)
        }
        
        return telefoneFormatado
    }

    // Componente reutilizável para TextField com erro
    private func customTextField(_ placeholder: String, text: Binding<String>, erroKey: String) -> some View {
        return VStack(alignment: .leading, spacing: 6) {
            TextField(placeholder, text: text)
                .onChange(of: text.wrappedValue) { _ in
                    validarCampo(text.wrappedValue, erroKey: erroKey)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            // Exibe a mensagem de erro abaixo do campo de texto
            if let mensagem = erros[erroKey], !mensagem.isEmpty {
                Text(mensagem)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
    }
}

struct AutenticacaoCadastralView_Previews: PreviewProvider {
    static var previews: some View {
        AutenticacaoCadastralView()
    }
}

extension Color {
    init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
