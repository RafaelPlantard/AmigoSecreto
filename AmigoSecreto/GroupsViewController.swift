//
//  GroupsViewController.swift
//  AmigoSecreto
//
//  Created by Rafael Ferreira on 12/25/20.
//

import UIKit

final class GroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    // MARK: Private variables

    private var groups: [String] = []

    // MARK: Override functions

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let nextViewController = segue.destination as? FriendsViewController, let group = sender as? String {
            nextViewController.title = group
        }
    }

    // MARK: IBActions

    @IBAction func addGroup(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Novo Grupo", message: "Qual o nome do grupo?", preferredStyle: .alert)

        alertController.addTextField { newTextField in
            newTextField.placeholder = "Digite aqui o nome do grupo"
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
        groups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewIdentifier", for: indexPath)
        cell.textLabel?.text = groups[indexPath.row]

        return cell
    }

    // MARK: UITableViewDelegate conforms

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = groups[indexPath.row]

        performSegue(withIdentifier: "GroupsSegue", sender: group)
    }

    // MARK: Private functions

    private func add(name: String) {
        groups.insert(name, at: 0)
        tableView.reloadData()
    }

    private func update(name: String, at indexPath: IndexPath) {
        groups[indexPath.row] = name
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
