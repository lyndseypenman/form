//
//  PickerFormField.swift
//  Form
//
//  Created by Lyndsey Penman on 21/04/2021.
//

import SwiftUI

struct PickerData<T: Codable> {
    let choices: [String]
    let placeholder: String
    let keypath: WritableKeyPath<T, String>
}

struct PickerFormField<T: Codable>: View {
    
    @EnvironmentObject var viewModel: FormViewModel<T>
    
    let pickerData: PickerData<T>
    
    var body: some View {
        Picker(pickerData.placeholder,
               selection: $viewModel.value[dynamicMember: pickerData.keypath]) {
            ForEach(pickerData.choices, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(InlinePickerStyle())
    }
}