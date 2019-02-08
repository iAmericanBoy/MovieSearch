//
//  MovieListViewController.swift
//  MovieSearch
//
//  Created by Dominic Lanzillotta on 2/8/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var movies:[Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - TableViewDataSource, TableViewDelegate
extension MovieListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count == 0 ? 1 : movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch movies.count  {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyMovieCell", for: indexPath)
            
            cell.textLabel?.text = "No movies Found"
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell
            
            cell?.movie = movies[indexPath.row]
            return cell ?? UITableViewCell()
        }

    }
}

//MARK: - SearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let movieName = searchBar.text else {return}
        searchBar.resignFirstResponder()
        MovieController.fetchMovieWith(name: movieName) { (movieList) in
            self.movies = movieList
            
        }
    }
}
