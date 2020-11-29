//
//  ReposListRepository.swift
//  PGR
//
//  Created by Ibram on 26/11/2020.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation

class ReposListRepository {
    var getRemoteDataObserver: ((_ response: Response<[ReposModel]>)->())?
    
    func getRemoteData() {
        Network.shared.request(router: Router.getReposData, model: [ReposModel]()) { (result) in
            switch result{
            case .success(let response):
                self.getRemoteDataObserver?(Response(data: response, error: nil))
            case .failure(let error):
                self.getRemoteDataObserver?(Response(data: nil, error: error.errorDescription))
            }
        }
    }
}
