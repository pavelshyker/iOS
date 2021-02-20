//
//  RecordsViewController.swift
//  GameProject
//
//  Created by Pavel Shyker on 9/28/20.
//  Copyright © 2020 Pavel Shyker. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {
    
    var recordResult = [Result]()
    var alertMessageTitle = "alertMessageTitle".localized()
    var alertConfirmActionTitle = "alertConfirmActionTitle".localized()
    var alertCancelActionTitle = "alertCancelActionTitle".localized()
    
    @IBOutlet weak var clearResultsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = view.backgroundColor
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        
        if let data = UserDefaults.standard.value(forKey: .record) as? Data {
            do {
                let recordResult = try JSONDecoder().decode([Result].self, from: data)
                self.recordResult = recordResult
            }
            catch {
                print (error.localizedDescription)
                recordResult = []
            }
        }
        else {
            recordResult = []
        }
        
        if recordResult.isEmpty {
            clearResultsButton.isEnabled = false
        }
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: alertMessageTitle, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: alertConfirmActionTitle, style: .default) { (_) in
            self.recordResult = [Result]()
            do {
                let data = try JSONEncoder().encode(self.recordResult)
                UserDefaults.standard.setValue(data, forKey: .record)
            }
            catch {
                print (error.localizedDescription)
            }
            self.tableView.reloadData()
            self.clearResultsButton.isEnabled = false
        }
        let cancelAction = UIAlertAction(title: alertCancelActionTitle, style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        present(alert, animated: true)
    }

    @IBAction func clearButtonTapped(_ sender: Any) {
        showAlert()
    }
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        recordResult.sort { $0.scoreRecord > $1.scoreRecord }
        let tableViewCell = UITableViewCell()
        let row = indexPath.row
        tableViewCell.textLabel?.text = "\(recordResult[row].userName) - \(recordResult[row].scoreRecord) - \(recordResult[row].recordDate)"
        tableViewCell.backgroundColor = view.backgroundColor
        tableViewCell.textLabel?.textAlignment = .center
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
