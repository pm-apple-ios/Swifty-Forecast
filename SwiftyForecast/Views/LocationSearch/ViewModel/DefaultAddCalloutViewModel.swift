import UIKit
import MapKit

struct DefaultAddCalloutViewModel: AddCalloutViewModel {
  var cityName: String { city.name }
  var country: String { city.country }
  
  private let city: City
  private let dataAccessObject: CityDAO
  private let modelTranslator: ModelTranslator
  
  init(placemark: MKPlacemark,
       dataAccessObject: CityDAO = DefaultCityDAO(),
       modelTranslator: ModelTranslator = ModelTranslator()) {
    self.city = City(placemark: placemark)
    self.dataAccessObject = dataAccessObject
    self.modelTranslator = modelTranslator
    self.city.isUserLocation = false
  }
  
  func add(completion: (Result<CityDTO, RealmError>) -> Void) {
    dataAccessObject.put(city)

    if let addedCity = modelTranslator.translate(city) {
      completion(.success(addedCity))
    } else {
      completion(.failure(.transactionFailed(description: "Faild to translate to DTO \(city)")))
    }
  }
}
