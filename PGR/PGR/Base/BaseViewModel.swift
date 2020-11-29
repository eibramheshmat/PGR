//
//  BaseViewModel.swift
//  PGR
//
//  Created by Ibram on 27/11/2020.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation

class BaseViewModel{
    
    var loading: ((_ isShow: Bool) -> ())?  /// to listen about loading at all view controllers
    var getErrorObserver: ((_ error: String)->())? /// to listen about error at all view controllers
}
