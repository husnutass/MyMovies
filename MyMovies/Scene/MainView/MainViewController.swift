//
//  ViewController.swift
//  MyMovies
//
//  Created by Hüsnü Taş on 23.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    
    var searchData = [Search]()
    var selectedId: String?
    
    
    private var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = MainViewModel(serviceProvider: ServiceProvider())
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        getSearchData(searchParam: nil)
    }
    
    
    private func getSearchData(searchParam: String?) {
        viewModel.fetchSearchData(searchParam: searchParam, completion: searchHandler)
    }
    
    lazy var searchHandler: (Result<SearchResponse?, Error>) -> () = { [weak self] result in
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.searchData = data.search
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
                self?.emptyLabel.isHidden = true
                
            case .failure(let error):
                print(error)
                self?.searchData = [Search]()
                self?.tableView.reloadData()
                self?.tableView.isHidden = true
                self?.emptyLabel.isHidden = false
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            let destination = segue.destination as! DetailViewController
            destination.selectedID = selectedId
        }
    }
    
}

extension MainViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MainTableViewCell
        cell.setup(search: searchData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedId = searchData[indexPath.row].imdbID
        performSegue(withIdentifier: "toDetailView", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension MainViewController: UISearchBarDelegate, UISearchDisplayDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearchData(searchParam: searchBar.text)
        searchBar.resignFirstResponder()
    }
    
}

