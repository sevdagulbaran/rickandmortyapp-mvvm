//
//  RickMortyViewController.swift
//  rickandmorty-app-mvvm
//
//  Created by Sevda Gul Baran on 24.01.2023.
//

import UIKit
import SnapKit

protocol RickMortyInterface {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}


final class RickMortyViewController: UIViewController {
    
    //MARK: - Properties
    
    private let titleLabel: UILabel = UILabel()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.setCollectionViewLayout(layout, animated: true)
        return collectionView
    }()
    
    private lazy var characterResults: [Result] = []
    
    lazy var viewModel: IRickMortyViewModel = RickMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
    private func configureUI() {
        addSubviews()
        registerCollectionView()
        drawDesing()
        makeTitleLabel()
        makeCollectionView()
        makeIndictor()
    }
}

//MARK: - RickMortyInterface

extension RickMortyViewController: RickMortyInterface {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        characterResults = values
        collectionView.reloadData()
    }
}

//MARK: -  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension RickMortyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characterResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RickMortyCollectionViewCell.Identifer, for: indexPath) as? RickMortyCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setModel(model: characterResults[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 200)
    }
}


// MARK: - UI Desing

private extension RickMortyViewController {
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(indicator)
    }
    
    func registerCollectionView() {
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(RickMortyCollectionViewCell.self, forCellWithReuseIdentifier: RickMortyCollectionViewCell.Identifer)
    }
    
    func drawDesing() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.titleLabel.font = .boldSystemFont(ofSize: 25)
            self.titleLabel.text = "Rick And Morty CharacterList"
            self.indicator.color = .red
        }
        indicator.startAnimating()
    }
    
    func makeTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
            
        }
    }
    
    func makeCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(titleLabel)
        }
    }
    
    func makeIndictor() {
        indicator.snp.makeConstraints { make in
            make.height.equalTo(titleLabel)
            make.right.equalTo(titleLabel).offset(-5)
            make.top.equalTo(titleLabel)
        }
    }
}
