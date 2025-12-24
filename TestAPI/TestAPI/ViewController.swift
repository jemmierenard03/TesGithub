//
//  ViewController.swift
//  TestAPI
//
//  Created by Jemmie Renard on 16/11/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func fetchButtonTapped(_ sender: Any) {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://api.github.com/users/jemmierenard") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else { return }

            do {
                let todo = try JSONDecoder().decode(Todo.self, from: data)
                DispatchQueue.main.async {
                    self.resultLabel.text =
                    """
                    Username: \(todo.login)
                    ID: \(todo.id)
                    Avatar URL: \(todo.avatar_url)
                    Repos URL: \(todo.repos_url)
                    """

                }
            } catch {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Decoding error"
                }
            }
        }.resume()
    }

    
}

