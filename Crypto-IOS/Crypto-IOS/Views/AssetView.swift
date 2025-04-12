import SwiftUI

struct AssetView: View {
    
    let asset: Asset
    
    var body: some View {
        HStack {
            AsyncImage(url: asset.iconUrl) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "dollarsign.gauge.chart.lefthalf.righthalf")
            }
            .frame(width: 40, height: 40)
            //Image(systemName: "square")
            
            VStack(alignment: .leading) {
                Text(asset.symbol)
                    .font(.headline)
                Text(asset.name)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Group
            {
                Image(systemName: asset.percentage >= 0 ? "chevron.up" : "chevron.down")
                
                Text("\(asset.formattedPercentage)%")
            }
                .foregroundStyle(asset.percentage >= 0 ? .green : .red)
            Text("$\(asset.formattedPrice)")
        }
        .padding(.horizontal)
    }
}


#Preview{
    AssetView(
        asset: .init(
            id: "bitcoin",
            name: "Bitcoin",
            symbol: "BTC",
            priceUsd: "87200",
            changePercent24Hr: "+8.78123123123123"
        )
    )
}
