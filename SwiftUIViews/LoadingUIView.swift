//
//  LoadingUIView.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 10/11/21.
//

import SwiftUI

struct LoadingUIView: View {
    
    let isLoading: Bool
    let error: NSError?
    let retryAction: (() -> ())?
    
    var body: some View {
        Group {
            if isLoading {
                HStack {
                    Spacer()
                    ActivityIndicatorView()
                    Spacer()
                }
            } else if error != nil {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text(error!.localizedDescription)
                        if self.retryAction != nil {
                            Button(action: self.retryAction!) {
                                Text("Retry")
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LoadingUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingUIView(isLoading: true, error: nil, retryAction: nil)
    }
}
