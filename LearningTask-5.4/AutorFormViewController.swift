//
//  ViewController.swift
//  LearningTask-5.4
//
//  Created by rafael.rollo on 09/03/2022.
//

import UIKit

class AutorFormViewController: UIViewController {
    
    typealias MensagemDeValidacao = String
    
    @IBOutlet weak var fotoTextField: UITextField!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var tecnologiasTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func botaoSalvarPressionado(_ sender: UIButton) {
        switch formularioEhValido() {
                    
                case (false, let mensagem):
                    exibeAlerta(titulo: "Erro", mensagem: mensagem)
                    
                default:
                    cadastraAutor()
                }
    }
    
    func nomeDeAutorValido(_ nome: String) -> Bool {
        let pattern = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: nome)
    }
    
    func formata(nomeDeAutor: String) -> (String, String) {
        let separador = " "
        let nomeCompleto = nomeDeAutor.components(separatedBy: separador)
        return (nomeCompleto.first!, nomeCompleto.dropFirst().joined(separator: separador))
    }
    
    func formularioEhValido() -> (Bool, MensagemDeValidacao?) {
            if let fotoUrl = fotoTextField.text, fotoUrl.isEmpty {
                return (false, "Informe a URL da foto do autor")
            }
            
            if let nome = nomeTextField.text, nome.isEmpty {
                return (false, "Nome não pode estar em branco")
            }
            
            guard nomeDeAutorValido(nomeTextField.text!) else {
                return (false, "Informe o nome completo do autor.")
            }
            
            if let bio = bioTextField.text, bio.isEmpty {
                return (false, "A bio do autor não pode estar em branco")
            }
            
            if let tecnologias = tecnologiasTextField.text, tecnologias.isEmpty {
                return (false, "Informe as tecnologias sobre as quais o autor escreve")
            }
            
            return (true, nil)
        }
    
    func cadastraAutor() {
            let (nomeAutor, sobrenomeAutor) = formata(nomeDeAutor: nomeTextField.text!)
            let autor = Autor(foto: fotoTextField.text!,
                              nome: nomeAutor,
                              sobrenome: sobrenomeAutor,
                              bio: bioTextField.text!,
                              tecologia: tecnologiasTextField.text!)
            
            AutorRepository.salva(autor)
            exibeAlerta(titulo: "Feito", mensagem: "Autor cadastrado com sucesso")
        }
    
    func exibeAlerta(titulo: String?, mensagem: String?) {
            let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            
            self.present(alert, animated: true, completion: nil)
        }
        
}
