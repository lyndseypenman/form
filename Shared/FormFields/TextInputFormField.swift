//
//  TextInputFormField.swift
//  Form
//
//  Created by Lyndsey Penman on 20/04/2021.
//

import SwiftUI

public struct TextInputData<T: Equatable> {
    var keypath: WritableKeyPath<T, String>
    let keyboardType: UIKeyboardType?
    let contentType: UITextContentType?
    let autocorrectType: UITextAutocorrectionType?
    let placeholder: String
    let maxCharacters: Int?
}

struct TextInputFormField<T: Equatable>: View {
    
    @EnvironmentObject var viewModel: FormViewModel<T>
    
    let textInputData: TextInputData<T>
    
    var body: some View {
        VStack {
            TextField(textInputData.placeholder,
                      text: $viewModel.value[dynamicMember: textInputData.keypath])
                .textFieldStyle(StyledTextField(
                                    keyboardType: textInputData.keyboardType,
                                    content: textInputData.contentType,
                                    autocorrectionType: textInputData.autocorrectType))
            if let maxCharacters = textInputData.maxCharacters {
                let characterCount = viewModel.value[keyPath: textInputData.keypath].count
                let valid = characterCount <= maxCharacters
                VStack(alignment: .trailing, spacing: 3) {
                    Divider()
                        .frame(minHeight: 1)
                        .background(valid ? Color.divider : Color.alertError)
                    Text("\(characterCount)/\(maxCharacters)")
                        .foregroundColor(valid ? Color.divider : Color.alertError)
                        .font(.captionCustom)
                        .kerning(0)
                }
            } else {
                Divider()
                    .frame(minHeight: 1)
                    .background(Color.divider)
            }
        }
    }
}
