//
//  HomeViewController.swift
//  IntegratedTestDojo
//
//  Created by Giovane Silva de Menezes Cavalcante on 25/08/20.
//  Copyright © 2020 GSMenezes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "HomeTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        viewModel.fetchAlbuns()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.setUp(with: viewModel.cellModel(for: indexPath))
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension HomeViewController: HomeViewDelegate {
    func reloadTable(_ viewModel: HomeViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ viewModel: HomeViewModel, message: String) {
        print("ERROR: \(message)")
    }
}
