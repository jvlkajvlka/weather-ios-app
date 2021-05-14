import Foundation


class WeatherViewModel: ObservableObject {
    
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Venice", "Paris", "Warsaw", "Berlin", "Barcelona", "London", "Prague", "Kraków"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    func refresh(record: WeatherModel.WeatherRecord, counter :Int){
        model.refresh(record: record, counter: counter)
    }
    func refreshState(record: WeatherModel.WeatherRecord, counter: Int){
        model.refreshState(record: record, counter: counter)
    }
}
