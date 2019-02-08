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

    //MARK: - Properties

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieController.fetchMovieWith(name: "Star Wars") { (movieList) in
            print(movieList)
        }
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
