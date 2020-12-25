//
//  FriendsViewController.swift
//  AmigoSecreto
//
//  Created by Rafael Ferreira on 12/25/20.
//

import UIKit

final class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    // MARK: Private variables

    private var friends: [String] = []

    // MARK: Override functions

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let nextViewController = segue.destination as? ShuffleViewController {
            nextViewController.setup(names: friends)
            nextViewController.title = title
        }
    }

    // MARK: IBActions

    @IBAction func addFriend(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Novo Participante", message: "Qual o nome do amigo?", preferredStyle: .alert)

        alertController.addTextField { newTextField in
            newTextField.placeholder = "Digite aqui o nome do participante:"
            newTextField.clearButtonMode = .whileEditing
        }

        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel))

        alertController.addAction(
            UIAlertAction(title: "Adicionar", style: .default) { [self] action in
                if let textField = alertController.textFields?.first, textField.hasText, let name = textField.text {
                    add(name: name)
                }
            }
        )

        present(alertController, animated: true, completion: nil)
    }

    // MARK: UITableViewDataSource conforms

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewIdentifier", for: indexPath)
        cell.textLabel?.text = friends[indexPath.row]

        return cell
    }

    // MARK: UITableViewDelegate conforms

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Participante", message: "Qual o nome do amigo?", preferredStyle: .alert)
        let oldName = friends[indexPath.row]

        alertController.addTextField { newTextField in
            newTextField.placeholder = "Digite aqui o nome do participante:"
            newTextField.clearButtonMode = .whileEditing
            newTextField.text = oldName
        }

        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel))

        alertController.addAction(
            UIAlertAction(title: "Salvar", style: .default) { [self] action in
                if let textField = alertController.textFields?.first, textField.hasText, let name = textField.text {
                    update(name: name, at: indexPath)
                }
            }
        )

        present(alertController, animated: true) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: Private functions

    private func add(name: String) {
        friends.insert(name, at: 0)
        tableView.reloadData()
    }

    private func update(name: String, at indexPath: IndexPath) {
        friends[indexPath.row] = name
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
