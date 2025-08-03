//
//  ViewController.swift
//  ToDoList
//
//  Created by Beshoy Atef on 03/08/2025.
//

import UIKit

class HomeViewController: UIViewController {

    var tasks = [String]()
    
    @IBOutlet var tasksTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedTasks = UserDefaults.standard.stringArray(forKey: "TASkENAME_KEY") {
            tasks = savedTasks
        }
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
       title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(AddButtonPressed))
    }
    @objc func AddButtonPressed() {
        if let entryTaskVC = storyboard?.instantiateViewController(identifier: "AddTaskViewController") as? AddTaskViewController {
            entryTaskVC.dataBack = {
                name in
                self.tasks.insert(name, at: 0)
                UserDefaults.standard.set(self.tasks, forKey: "TASkENAME_KEY")
                self.tasksTableView.reloadData()
            }
            navigationController?.pushViewController(entryTaskVC, animated: true)
        }
    }

}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell {
            cell.taksNameLabel.text = tasks[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                tasks.remove(at: indexPath.row)
                UserDefaults.standard.set(tasks, forKey: "TASkENAME_KEY")
                tasksTableView.reloadData()
            }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let editVC = storyboard?.instantiateViewController(withIdentifier: "TaskEditPopUpVC") as? TaskEditPopUpVC {
            editVC.editingDataBack = {
                data in
                self.tasks[indexPath.row] = data
                UserDefaults.standard.set(self.tasks, forKey: "TASkENAME_KEY")
                self.tasksTableView.reloadData()
            }
            present(editVC, animated: true)

        }
    }
}

