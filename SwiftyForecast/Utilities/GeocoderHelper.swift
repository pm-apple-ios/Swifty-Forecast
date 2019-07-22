import Foundation
import CoreLocation

final class GeocoderHelper {
  static private let geocoder = CLGeocoder()
  
  class func coordinate(by address: String, completionHandler: @escaping (Result<CLLocationCoordinate2D, GeocoderError>) -> ()) {
    geocoder.geocodeAddressString(address) { placemarks, error in
      guard let placemark = placemarks?.last,
            let coordinate = placemark.location?.coordinate, error == nil else {
          completionHandler(.failure(GeocoderError.coordinateNotFound))
          return
      }
      
      completionHandler(.success(coordinate))
    }
  }
  
  class func place(at coordinate: CLLocationCoordinate2D, completionHandler: @escaping (Result<CLPlacemark, GeocoderError>) -> ()) {
    let location = CLLocation(latitude: CLLocationDegrees(coordinate.latitude), longitude: CLLocationDegrees(coordinate.longitude))
    geocoder.reverseGeocodeLocation(location) { placemarks, error in
      guard let placemark = placemarks?.first, error == nil else {
        completionHandler(.failure(GeocoderError.placeNotFound))
        return
      }
      
      completionHandler(.success(placemark))
    }
  }
  
  class func currentPlace(completionHandler: @escaping (Result<CLPlacemark, GeocoderError>) -> ()) {
    guard LocationProvider.shared.isLocationServicesEnabled else {
      completionHandler(.failure(.locationDisabled))
      return
    }
    
    LocationProvider.shared.requestLocation() { location in
      GeocoderHelper.place(at: location.coordinate) { result in
        switch result {
        case .success(let data):
          completionHandler(.success(data))
          
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
  class func timeZone(for coordinate: CLLocationCoordinate2D, completionHandler: @escaping (Result<TimeZone, GeocoderError>) -> ()) {
    let location = CLLocation(latitude: CLLocationDegrees(coordinate.latitude), longitude: CLLocationDegrees(coordinate.longitude))
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
      guard let placemark = placemarks?.first,
            let timezone = placemark.timeZone, error == nil else {
          completionHandler(.failure(GeocoderError.timezoneNotFound))
          return
      }
      
      completionHandler(.success(timezone))
    }
  }
}
