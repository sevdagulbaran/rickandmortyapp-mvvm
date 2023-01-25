//
//  RickMortyService.swift
//  rickandmorty-app-mvvm
//
//  Created by Sevda Gul Baran on 24.01.2023.
//

import Alamofire

enum RickMortyServiceEndPoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api/"
    case PATH = "/character"
    
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickMortyService {
    func fetchAllDatas(response: @escaping ([Result]?) -> Void )
}

struct RickMortyService: IRickMortyService {
    
    func fetchAllDatas(response: @escaping ([Result]?) -> Void) {
        AF.request(RickMortyServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self) { (model) in
            guard let data = model.value else {
                response(nil)
                return }
            
            response(data.results)
        }
    }
}
