//
//  RickMortyViewModel.swift
//  rickandmorty-app-mvvm
//
//  Created by Sevda Gul Baran on 24.01.2023.
//

protocol IRickMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var rickMortyCharacters: [Result] { get set }
    var rickMortyService: IRickMortyService { get  }
    
    var rickMortyOutput: RickMortyInterface? { get }
    func setDelegate(output: RickMortyInterface)
}

final class RickMortyViewModel: IRickMortyViewModel {
    var rickMortyOutput: RickMortyInterface?
    
    func setDelegate(output: RickMortyInterface) {
        rickMortyOutput = output
    }
    
    var rickMortyCharacters: [Result] = []
    private var isLoading = false
    var rickMortyService: IRickMortyService
    
    init() {
        rickMortyService = RickMortyService()
    }
    
    func fetchItems() {
        changeLoading()
        rickMortyService.fetchAllDatas { [weak self] response in
            self?.changeLoading()
            self?.rickMortyCharacters = response ?? []
            self?.rickMortyOutput?.saveDatas(values: self?.rickMortyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickMortyOutput?.changeLoading(isLoad: isLoading)
    }
}
