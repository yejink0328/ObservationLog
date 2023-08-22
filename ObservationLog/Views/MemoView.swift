//
//  MemoView.swift
//  ObservationLog
//
//  Created by MAX on 2023/08/21.
//

import SwiftUI

struct MemoView: View {
    var body: some View {
        VStack {
            Text("비어있는 기록 1")
            Text("2023. 8. 18.")
            
            VStack(spacing: 10) {
                Text("21시 56분")
                    .frame(width: 300, alignment: .leading)
                Text("비어있는 기록 1의 내용이 적힌 메모")
                    .frame(width: 300, alignment: .leading)
                    .font(.title2)
            }
            .padding()
            .border(.black)
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
    }
}
