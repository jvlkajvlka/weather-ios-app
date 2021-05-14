import SwiftUI

let weatherRecordViewHeight = CGFloat(100)
let rectangleCornerRadius = CGFloat(25.0)
let weatherIconScale = CGFloat(0.85)
let textPriority = 100.0

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
            ScrollView{
                VStack{
                    ForEach(viewModel.records) {record in
                        WeatherRecordView(record: record, viewModel: viewModel)
                    }
                }.padding()
            }
        }
}

struct WeatherRecordView: View{
    var descriptions = ["Snow": "❄", "Sleet": "❄", "Hail":"⛈", "Thunderstorm":"🌩", "Heavy Rain":"🌧", "Light Rain":"🌧", "Showers":"🌦", "Heavy Cloud":"☁️", "Light Cloud":"🌤", "Clear":"☀️"]
    @State var counter : Int = 0
    
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel
    var body: some View{
        ZStack{
            //prostokat z zaakraglonymi rogami
            RoundedRectangle(cornerRadius: rectangleCornerRadius)
                .stroke()
            GeometryReader { geometry in //dodanie funkcjonalnosci przewijania ekranu
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: { //tworzymy Hstacka bo chcemy liste poziomych elementow
                    Text("\(descriptions[record.weatherState]!)")
                        .font(.system(size: weatherIconScale * geometry.size.height)) //dopasowanie rozmiaru do otrzymanej przestrzeni
                        .frame(alignment: .trailing) //wyrownanie do lewej
                    
                    Spacer() // wstawienie spacera aby rozdzielić ikonę pogody od tekstu

                    VStack (alignment: .leading) { //wyrownanie elementow Vstacku do lewej
                        Text(record.cityName)
                        Text(record.recordState)
                            .font(.caption) //ustawienie rozmniaru czcionki
                            .onTapGesture {
                                self.counter += 1
                                if counter > 2 {
                                    self.counter = 0
                                }
                                viewModel.refreshState(record: record, counter: self.counter)
                                
                            }
                    }.layoutPriority(textPriority)          //ustalenie priorytetu aby oba texty zawsze były całe
                    
                    Spacer()  // wstawienie spacera aby rozdzielić tekst od ikonki refreshu
                    
                    Text("🔄")
                        .font(.largeTitle) //ustawiamy rozmiar czcionki
                        .frame(alignment: .trailing) //wyrownanie elementu do prawej
                        .onTapGesture {
                            if counter > 2 {
                                self.counter = 0
                            }
                            viewModel.refresh(record: record, counter: counter) //po kliknieciu na tekst zmieniamy wyswieltana informacje
                        }
                })
            }.padding()// dodanie wewnętrznego padingu do GeometryReadera

        }.frame(height: weatherRecordViewHeight) //ustawienie wysokosci przeze mnie zdefiniowanej
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
    
}
