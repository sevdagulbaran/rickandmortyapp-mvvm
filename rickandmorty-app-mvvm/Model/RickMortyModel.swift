//
//  RickMortyModel.swift
//  rickandmorty-app-mvvm
//
//  Created by Sevda Gul Baran on 24.01.2023.
//

//MARK: - PostModel

struct PostModel: Codable {
    let info: Info?
    let results: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case info
        case results
    }
}

//MARK: - Info

struct Info: Codable {
    let count: Int?
    let pages: Int?
    let next: String?
}

//MARK: - Result

struct Result: Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Location?
    let location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

//MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
    
    
}
