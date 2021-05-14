import Foundation


struct WeatherModel {
    var records: Array<WeatherRecord> = []
    var descriptions = ["Snow": "❄", "Sleet": "❄", "Hail":"⛈", "Thunderstorm":"🌩", "Heavy Rain":"🌧", "Light Rain":"🌧", "Showers":"🌦", "Heavy Cloud":"☁️", "Light Cloud":"🌤", "Clear":"☀️"]

    
    init(cities: Array<String>){
        records = Array <WeatherRecord>()
        for city in cities {
            records.append(WeatherRecord(cityName: city))
        }
    }
    
    
    
    struct WeatherRecord: Identifiable {
        var id: UUID = UUID()
        var cityName: String
        var weatherState: String = "Snow"
        var temperature: Float = Float.random(in: -10.0 ... 30.0).rounded()
        var humidity: Float = Float.random(in: 0 ... 100).rounded()
        var windSpeed: Float = Float.random(in: 0 ... 20).rounded()
        var windDirection: Float = Float.random(in: 0 ..< 360).rounded()
        var recordState: String = "Temperature: 23 ℃"
    }
    
    
    mutating func refresh(record: WeatherRecord){

        let index = records.firstIndex(where: {$0.id == record.id})
        let temperature = Float.random(in: -10.0 ... 30.0) //losujemy wartosci
        let humidity = Float.random(in: 0 ... 1000)
        let windSpeed = Float.random(in: 0 ... 20).rounded()
        
        records[index!].temperature = round(temperature * 100) / 100 //zaokraglamy i przypisujemy do uzywanych
        records[index!].humidity = round(humidity * 100) / 100
        records[index!].windSpeed = round(windSpeed * 100) / 100
        records[index!].weatherState = descriptions.randomElement()!.key //po kazdym refreshu od zer pokazuje sie temperatura
        
        records[index!].recordState = "Temperature: \(record.temperature) ℃"
        print("Refreshing record: \(record.cityName)")
    }
    
    mutating func refreshState(record: WeatherRecord, counter: Int){
        let index = records.firstIndex(where: {$0.id == record.id})
        let states = [ "Temperature: \(record.temperature) ℃",
                       "Humidity: \(record.humidity) %",
                       "Wind speed: \(record.windSpeed) km/h"]
        records[index!].recordState = states[counter] //przypisanie cykliczne za pomoca wproawadzanego countera
    }
}

