//
//  MoviesViewController.swift
//  Cinetopia
//
//  Created by Giovanna Moeller on 30/10/23.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private var movieService: MovieService = MovieService()
    
    private lazy var mainView: MoviesView = {
        let moviesView = MoviesView()
            
        return moviesView
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupDelegate()
        setupNavigationBar()
        Task {
            await fetchMovies()
        }
    }
    
    func setupDelegate() {
        mainView.delegate = self
    }
    
    private func fetchMovies() async {
        do {
            let movies = try await movieService.getMovies()
            mainView.setupView(with: movies)
            mainView.reloadData()
        } catch (let error) {
            print(error)
        }
    }
    
    private func setupNavigationBar() {
        title = "Filmes Populares"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.titleView = mainView.searchBar
    }
}

extension MoviesViewController: MoviesViewDelegate {
    func didSelectMovie(_ movie: Movie) {
        let detailsVC = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
