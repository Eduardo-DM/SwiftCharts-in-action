//
//  PlaceOrderView.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 25/11/22.
//

import SwiftUI

struct PlaceOrderView: View {
    
    @ObservedObject var coverageVM: CoverageVM
    
    @FocusState private var keyboardControl: CoverageVM.KeyboardControl?
    
    let forceNumber: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        ScrollView{
            DatePicker("Order date", selection: $coverageVM.draftingDate, in: coverageVM.firstDay ... coverageVM.lastDay, displayedComponents: .date)
                .datePickerStyle(.compact)
            VStack{
                HStack{
                    Text("Enter replenishment quantity")
                    Spacer()
                    TextField("", value: $coverageVM.draftingQuantity, format: .number)
                        .toolbar{
                            ToolbarItem(placement: .keyboard) {
                                Button {
                                    keyboardControl = nil
                                } label: {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                }
                            }
                        }
                        .focused($keyboardControl, equals: .show)
                        .keyboardType(.numberPad)
                        .padding(.horizontal,10)
                        .padding(.vertical,2)
                        .background(.thickMaterial)
                        .mask { RoundedRectangle(cornerRadius: 10, style: .continuous) }
                        .frame(width:80, alignment: .trailing)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Button("Save replenishemt") {
                coverageVM.placeReplenishment(when: coverageVM.draftingDate, howMany: coverageVM.draftingQuantity)
                coverageVM.showPlaceReplenishementView = false
                keyboardControl = nil
            }
            .buttonStyle(.bordered)
            .tint(.blue.opacity(0.9))
        }
    }
}

struct PlaceOrderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceOrderView(coverageVM: .testCoverageVM)
    }
}
