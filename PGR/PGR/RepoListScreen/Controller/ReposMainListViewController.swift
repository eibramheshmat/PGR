//
//  ReposMainListViewController.swift
//  PGR
//
//  Created by Ibram on 26/11/2020.
//  Copyright © 2020 Ibram. All rights reserved.
//

import UIKit

class ReposMainListViewController: BaseViewController<ReposListViewModel> {

    @IBOutlet weak var repoMainListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ReposListViewModel()
        setViewModelObserver()
        viewModel.getRemoteData()
        registerCell()
    }

    private func registerCell() {
        repoMainListTableView.register(UINib(nibName: "ReposMainListTableViewCell", bundle: nil), forCellReuseIdentifier: "ReposMainListTableViewCell")
    }
    
    private func setViewModelObserver(){
        self.supscripLoadingState()
        viewModel.getDataObserver = { [weak self] in
            self?.repoMainListTableView.reloadData()
        }
        viewModel.getErrorObserver = { [weak self] (error) in
            self?.showAlert(message: "Error about get local data")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goDetailsFromMain":
            if let viewControllerDestination = segue.destination as? RepoDetailsViewController, let repo = sender as? ReposModel {
                viewControllerDestination.repoDetailsData = repo
            }
        default:
            break
        }
    }
}

//MARK:- TableView Datasource
extension ReposMainListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.repoDataToShow.isEmpty{
            tableView.setEmptyView(title: "Sorry! No Repositories Found", message: "Please try again later", image: #imageLiteral(resourceName: "nodata"))
        }else{
            tableView.restore()
        }
        return viewModel.repoDataToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repoMainListTableView.dequeueReusableCell(withIdentifier: "ReposMainListTableViewCell", for: indexPath) as! ReposMainListTableViewCell
        cell.fillCellData(cellData: viewModel.repoDataToShow[indexPath.row])
        return cell
    }
    
    
}

//MARK:- TableView Delegate
extension ReposMainListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goDetailsFromMain", sender: viewModel.repoDataToShow[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this line of code can detect that scroll reach at the end of tableView
        if indexPath.row == viewModel.repoDataToShow.count-1 {
            viewModel.getNextPage()
        }
    }
}
