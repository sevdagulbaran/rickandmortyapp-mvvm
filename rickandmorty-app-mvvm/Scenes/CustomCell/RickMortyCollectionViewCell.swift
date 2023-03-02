//
//  RickMortyCollectionViewCell.swift
//  rickandmorty-app-mvvm
//
//  Created by Sevda Gul Baran on 25.01.2023.
//

import UIKit
import AlamofireImage

class RickMortyCollectionViewCell: UICollectionViewCell {
    
    static let Identifer: String = "cell"
    
    //MARK: - Properties
    
    private let characterImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    
    private let randomImage: String = "https://picsum.photos/200/300"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Desing
    
    private func configure() {
        addSubview(characterImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    
        titleLabel.font = .boldSystemFont(ofSize: 18)
        descriptionLabel.font = .italicSystemFont(ofSize: 10)

        
        characterImageView.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.top.equalTo(contentView).offset(30)
            make.left.equalTo(contentView)
            make.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(characterImageView.snp.bottom).offset(10)
            make.right.left.equalTo(contentView)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel).offset(5)
            make.right.left.equalTo(titleLabel)
            make.bottom.equalToSuperview()
        }
    }
    //MARK: - Set data

    func setModel(model: Result) {
        titleLabel.text = model.name
        descriptionLabel.text = model.status
        characterImageView.af.setImage(withURL: URL(string: model.image ?? randomImage) ?? URL(string: randomImage)!)
      }
}
