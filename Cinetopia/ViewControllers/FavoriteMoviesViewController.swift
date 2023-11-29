//
//  FavoriteMoviesViewController.swift
//  Cinetopia
//
//  Created by Ândriu F Coelho on 12/11/23.
//

import UIKit
import SwiftUI

class FavoriteMoviesViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 27, bottom: 10, right: 27)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavoriteMovieCollectionViewCell.self, forCellWithReuseIdentifier: "favoriteCell")
        
        collectionView.register(FavoriteCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
        return collectionView
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension FavoriteMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieManager.shared.favoritesMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? FavoriteMovieCollectionViewCell else {
            fatalError("error to create cell")
        }
        
        let currentMovie = MovieManager.shared.favoritesMovies[indexPath.item]
        cell.setupView(currentMovie)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as? FavoriteCollectionReusableView else {
                fatalError("error to create header collectionview")
            }
            header.setupTitle("Meus filmes favoritos")
                
            return header
        }
        return UICollectionReusableView()
    }
}

extension FavoriteMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}

extension FavoriteMoviesViewController: FavoriteMovieCollectionViewCellDelegate {
    func didSelectFavoriteButton(sender: UIButton) {
        guard let cell = sender.superview as? FavoriteMovieCollectionViewCell else {
            return
        }

        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }

        let selectedMovie = MovieManager.shared.favoritesMovies[indexPath.item] // Atenção aqui
        selectedMovie.changeSelectionStatus()
        MovieManager.shared.remove(selectedMovie)
        
        collectionView.reloadData()
    }
}
