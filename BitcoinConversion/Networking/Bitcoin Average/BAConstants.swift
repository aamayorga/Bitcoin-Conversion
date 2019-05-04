//
//  BAConstants.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/2/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import Foundation

class BAConstants {
    
    struct BAURLComponents {
        static let ApiScheme             = "https"
        static let ApiHost               = "apiv2.bitcoinaverage.com"
    }
    
    struct BARequest {
        static let Converter             = "/convert"
        static let ExchangeRates         = "/exchangerates"
        static let Constants             = "/constants"
        static let SymbolSetGlobal       = "/global"
        static let SymbolSetLocal        = "/local"
    }
    
    struct BAParameterKeys {
        static let FromSourceCur         = "from"
        static let ToTargetCur           = "to"
        static let Amount                = "amount"
    }
}
