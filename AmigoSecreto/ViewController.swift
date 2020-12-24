//
//  ViewController.swift
//  AmigoSecreto
//
//  Created by Rafael Ferreira on 12/24/20.
//

import UIKit

final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberTextField: UITextField!

    // MARK: Private variables

    private var names: [String] = [
        "Rafael Ferreira",
        "Cleís Aurora",
        "Elsie Aurora",
        "Clício Ribas",
        "Jairo Correa",
        "Neiva Correa",
        "Talita Correa",
        "Cleber Augusto",
        "Glauber Márcio",
        "Érica Batista"
    ]

    private var numberDiscovered: [Int] = []

    // MARK: Overide functions

    override func viewDidLoad() {
        super.viewDidLoad()

        shuffle()
    }

    // MARK: IBActions

    @IBAction func refreshOrder(_ sender: UIBarButtonItem) {
        numberDiscovered = []
        shuffle()
    }

    @IBAction func discover() {
        if numberTextField.hasText, let numberString = numberTextField.text,
           let number = Int(numberString), number > 0, number <= names.count, !numberDiscovered.contains(number - 1) {
            numberDiscovered.insert(number - 1, at: 0)
            tableView.reloadData()
        }

        numberTextField.text = ""
    }

    // MARK: UITableViewDataSource & UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberDiscovered.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewIdentifier", for: indexPath)

        cell.textLabel?.text = names[numberDiscovered[indexPath.row]]
        cell.detailTextLabel?.text = String(numberDiscovered[indexPath.row] + 1)

        return cell
    }

    // MARK: Private functions

    private func shuffle() {
        (0...names.count).forEach { _ in
            names.shuffle()
        }

        tableView.reloadData()
    }
}

