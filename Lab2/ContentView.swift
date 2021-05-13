import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    var height: CGFloat = 800
    var width: CGFloat = 300
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                VStack{
                    ForEach(viewModel.records) {record in
                        WeatherRecordView(record: record, viewModel: viewModel)
                    }
                }.padding()
                .frame(width: width, height: height, alignment: .center)
            }
        }
        
    }
}

struct WeatherRecordView: View{
    var descriptions = ["Snow": "❄", "Sleet": "❄", "Hail":"⛈", "Thunderstorm":"🌩", "Heavy Rain":"🌧", "Light Rain":"🌧", "Showers":"🌦", "Heavy Cloud":"☁️", "Light Cloud":"🌤", "Clear":"☀️"]
    @State var counter : Int = 1
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 25.0)
                .stroke()
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30, content: {
            
                Text("\(descriptions[record.weatherState]!)")
                    .font(.largeTitle)
                    .frame(width: 30 ,height: 10, alignment: .trailing)
                    .truncationMode(.tail)

                VStack(alignment: .leading, spacing: 8, content: {
                    Text(record.cityName)
                    Text(record.recordState)
                        .font(.caption)
                        .onTapGesture {
                            viewModel.refreshState(record: record, counter: self.counter)
                            self.counter += 1
                            if counter > 2 {
                                self.counter = 0
                            }
                        }
                })
                Text("🔄")
                    .font(.largeTitle)
                    .frame(alignment: .trailing)
                    .onTapGesture {
                        viewModel.refresh(record: record)
                    }
                    
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
    
}
