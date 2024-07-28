//
//  DashboardViewController.swift
//  SADemo
//
//  Created by Rahul Gupta on 20/07/24.
//

import UIKit

class DashboardViewController: MasterViewController {

    private var viewModel = DashboardViewModel()
    @IBOutlet weak var inspectionTable: UITableView! {
        didSet {
            inspectionTable.rowHeight = UITableView.automaticDimension
            inspectionTable.register(UINib(nibName: "InspectionTableViewCell", bundle: nil), forCellReuseIdentifier: "InspectionTableViewCell")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        updateUI()
        viewModel.getRandomInspection()
    }

    @IBAction func startInspection(_ sender: UIButton) {
        viewModel.startInspection()
    }

    @IBAction func submitInspection(_ sender: UIButton) {
        viewModel.submitInspection()
    }

    @IBAction func getInspection(_ sender: UIButton) {
        viewModel.getInspection(id: 3)
    }

    @IBAction func generateRandomInspections(_ sender: UIButton) {
        viewModel.generateRandomInspections()
    }


    func updateUI() {
        self.inspectionTable.dataSource = self
        self.inspectionTable.delegate = self

        viewModel.onSuccess = {
            // Handle success, update UI or perform segue
            DispatchQueue.main.async {
                let appDel = UIApplication.shared.delegate as! AppDelegate
                let viewContext = appDel.persistentContainer.viewContext
                let fetchRequest = Inspection.fetchRequest()
                let inspection = try? viewContext.fetch(fetchRequest)
                if inspection != nil {
                    print(inspection?.first?.area?.id ?? 0)
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.showAlert(tittle: "Success!!", messsage: "Inspection started successfully!!")
            })
        }

        viewModel.commonSuccess = { message in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.showAlert(tittle: "Success!!", messsage: message)

            })
        }

        viewModel.onFailure = { error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.showAlert(tittle: "Error!!", messsage: error.localizedDescription)
            })
        }

        viewModel.onGetRandomInpectionSuccess = {
            DispatchQueue.main.async {
                self.inspectionTable.reloadData()
            }
        }
    }
}
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.inspection.count > 0 ? 1 : 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.inspection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InspectionTableViewCell", for: indexPath) as! InspectionTableViewCell
        cell.updateCell(inspection: self.viewModel.inspection[indexPath.row].inspection)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Alert!", message: "Are you sure want to delete inspection?", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.viewModel.deleteInspection(id: Int(self.viewModel.inspection[indexPath.row].inspection.id))
        }

        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in }
        alertController.addAction(okAction)
        alertController.addAction(cancel)

        present(alertController, animated: true, completion: nil)

    }
}
