//
//  Collection.swift
//  ReusableCollectionView
//
//  Created by Adriano Ramos on 17/05/20.
//  Copyright © 2020 Adriano Ramos. All rights reserved.
//

import SwiftUI


/*
 Content(View) represents whatever view type we nest inside the collection cells
 Data(Hashable) represents the data source for the collection
 */
struct Collection<Content: View, Data: Hashable>: View {
    
    @Binding var data: [Data]
    let viewBuilder: (Data) -> Content
    let cols: Int
    let spacing: CGFloat
    
    /*
     data (Binding<[Data]>) will be the data feeding the Collection view. We use a binding here to ensure any changes are reflected in our Collection view
     
     viewBuilder ((Data) -> Content) will return the view we are embedding within our Collection cells
     
     cols (Int) is the number of columns we want to show
     
     spacing (CGFloat) is the spacing we want between cells (vertical and horizontal)
     */
    
    init(data: Binding<[Data]>, cols: Int = 3, spacing: CGFloat = 5, _ viewBuilder: @escaping (Data) -> Content) {
        
        _data = data
        self.cols = cols
        self.spacing = spacing
        self.viewBuilder = viewBuilder
    }
    
    private func cell(colIndex: Int, rowIndex: Int) -> some View {
        let cellIndex = (rowIndex * cols) + colIndex
        return ZStack {
            if cellIndex < data.count {
                self.viewBuilder(data[cellIndex])
            }
        }
    }

    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                self.setupView(geometry: geometry).frame(minHeight: geometry.frame(in: .global).height)

            }
            
        }
    }
    
    private func setupView(geometry: GeometryProxy) -> some View {
        let rowRemainder = Double(data.count).remainder(dividingBy: Double(cols))
        let rowCount = data.count / cols + (rowRemainder == 0 ? 0 : 1)
        let frame = geometry.frame(in: .global)
        let totalSpacing = Int(spacing) * (cols - 1)
        let cellWidth = (frame.width - CGFloat(totalSpacing))/CGFloat(cols)

        return VStack(alignment: .leading, spacing: spacing) {
            ForEach(0...rowCount-1, id: \.self) { row in
                HStack(spacing: self.spacing) {
                    ForEach(0...self.cols-1, id: \.self) { col in
                        self.cell(colIndex: col, rowIndex: row)
                        .frame(maxWidth: cellWidth)
                    }
                }
            }
            Spacer()
        }
    }

}

//struct Collection_Previews: PreviewProvider {
//    static var previews: some View {
//        Collection<Content: View, Data: Hashable>()
//    }
//}
