//
//  Copyright © 2018 Krzysztof Lech. All rights reserved.

import Foundation
import Alamofire

enum API {
    static let apiKey = "AIzaSyAagv-IJ4Q15KTRG8GStou35HjROXE5WXI"
    static let googleHost = "maps.googleapis.com"
    static let nearbyPath = "/maps/api/place/nearbysearch/json"
    static let imagePath = "/maps/api/place/photo"
    static let radius = "5000"
}
    

struct APIService {
    
    func fetchNearbyPlaces(url: URL?, completion: @escaping (_ data: NearbyPlaces) -> ()) {
        guard let endPointUrl = url else {
            print("Error: Cannot create URL")
            return
        }
        
        Alamofire.request(endPointUrl)
            .responseData { (dataResponse) in
                guard let data = dataResponse.data else { return }

                do {
                    let apiData = try JSONDecoder().decode(NearbyPlaces.self, from: data)
                    //print(apiData)
                    completion(apiData)
                } catch {
                    print("Decode error: ", error)
                }
            }
    }

    func fetchPlaceImage(url: URL?, completion: @escaping (_ data: UIImage) -> ()) {
        guard let endPointUrl = url else {
            print("Error: Cannot create URL")
            return
        }
        
        Alamofire.request(endPointUrl)
            .responseData { (dataResponse) in
                guard let data = dataResponse.data, let image = UIImage(data: data) else { return }
                completion(image)
        }
    }
    
    func nearbyPlacesRequest(location: Location, andType type: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = API.googleHost
        urlComponents.path = API.nearbyPath

        let locationItem = URLQueryItem(name: "location", value: String(format: "%0.7f,%0.7f", location.latitude, location.longitude))
        let radiusItem = URLQueryItem(name: "radius", value: API.radius)
        let typeItem = URLQueryItem(name: "type", value: type)
        let apiKeyItem = URLQueryItem(name: "key", value: API.apiKey)
        let queryItems: [URLQueryItem] = [locationItem, radiusItem, typeItem, apiKeyItem]
        
        ///let pagetokenItem = URLQueryItem(name: "pagetoken", value: xx)
        ///let queryItems: [URLQueryItem] = [locationItem, radiusItem, typeItem, pagetokenItem, apiKeyItem]
        
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }
    
    func imageRequest(width: Int, photoReference: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = API.googleHost
        urlComponents.path = API.imagePath

        let maxWidthItem = URLQueryItem(name: "maxwidth", value: String(width))
        let photoReferenceItem = URLQueryItem(name: "photoreference", value: photoReference)
        let apiKeyItem = URLQueryItem(name: "key", value: API.apiKey)
        let queryItems: [URLQueryItem] = [maxWidthItem, photoReferenceItem, apiKeyItem]
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }

    
}
