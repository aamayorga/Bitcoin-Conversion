//
//  BAClient.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/2/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import Foundation
import Alamofire

// Custom MyResult was used due to namespace error with Alamofire
enum MyResult<T, E: Error> {
    case success(T)
    case failure(E)
}

class BAClient {
    func getPriceConversion(from sourceCurrency: String, to targetCurrency: String, amount: Double, completion: @escaping (MyResult<PriceConversion, NetworkError>) -> Void) {
        
        let request = [BAConstants.BARequest.Converter, BAConstants.BARequest.SymbolSetGlobal]
        let parameterKeys = [BAConstants.BAParameterKeys.FromSourceCur, BAConstants.BAParameterKeys.ToTargetCur, BAConstants.BAParameterKeys.Amount]
        let parameterValues = ["\(sourceCurrency)", "\(targetCurrency)", "\(amount)"]
        
        guard let url = baUrlWithUrlRequests(request, parameterKeys, parameterValues) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        Alamofire.request(url).validate().responseJSON { (response) in
            
            guard response.result.isSuccess else {
                completion(.failure(.invalidRequest))
                return
            }
            
            guard let value = response.data else {
                completion(.failure(.invalidData))
                return
            }
            
            self.convertDataToPriceConversion(value, completion: { (result) in

                switch result {

                case .success(let priceConversion):
                    completion(.success(priceConversion))

                case .failure(let error):
                    completion(.failure(error))

                }
            })
        }
    }
    
    func convertDataToPriceConversion(_ data: Data, completion: (MyResult<PriceConversion, NetworkError>) -> Void) {
        
        var priceConversion: PriceConversion
        
        do {
            let decoder = JSONDecoder()
            priceConversion = try decoder.decode(PriceConversion.self, from: data)
        } catch {
            completion(.failure(.failedToDecode))
            return
        }
        
        completion(.success(priceConversion))
    }
    
    func baUrlWithUrlRequests(_ requests: [String], _ paramKeys: [String]?, _ paramValues: [String]?) -> URL? {
        var components = URLComponents()
        components.scheme = BAConstants.BAURLComponents.ApiScheme
        components.host = BAConstants.BAURLComponents.ApiHost
        components.query = ""
        
        for request in requests {
            components.path.append(request)
        }
        
        var urlQueryItems: [URLQueryItem] = []
        
        let parameters = zip(paramKeys ?? [""], paramValues ?? [""])
        parameters.forEach { (key, value) in
            let queryItem = URLQueryItem(name: key, value: value)
            urlQueryItems.append(queryItem)
        }
        
        components.queryItems = urlQueryItems
        
        guard let url = components.url else {
            return nil
        }
        
        return url
    }
}
