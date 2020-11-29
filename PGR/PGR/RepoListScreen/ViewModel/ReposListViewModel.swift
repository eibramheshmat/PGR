//
//  ReposListViewModel.swift
//  PGR
//
//  Created by Ibram on 26/11/2020.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation

class ReposListViewModel: BaseViewModel {
    lazy var allRepoData = [ReposModel]()
    lazy var repoTemp = [ReposModel]()
    var repoDataToShow = [ReposModel](){
        didSet{
            loading?(false)
            getDataObserver?()
        }
    }
    lazy var repoListRepository = ReposListRepository()
    var getDataObserver: (()->())?
    
    func getRemoteData(){
        loading?(true)
        setRepositoryObserver()
        repoListRepository.getRemoteData()
    }
    
    /* This method to make loacal pagination */
    func getNextPage(){
        if allRepoData.count > repoDataToShow.count{
            for index in repoDataToShow.count..<repoDataToShow.count+10{
                repoTemp.append(allRepoData[index])
            }
            repoDataToShow = repoTemp
        }
    }
    
    private func setRepositoryObserver(){
        repoListRepository.getRemoteDataObserver = { [weak self] (response) in
            if let data = response.data{
                self?.allRepoData = data
                self?.getNextPage()
            }
            if let error = response.error{
                self?.loading?(false)
                self?.getErrorObserver?(error)
            }
        }
    }
}
