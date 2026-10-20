//
//  test.swift
//  Delee
//
//  Created by Шабнам Шарипова on 06/09/26.
//

import SwiftUI

struct TestScroll: View {
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                Button("Прыгнуть к 50") {
                    withAnimation {
                        proxy.scrollTo(50, anchor: .top)
                    }
                }
                .padding()

                ScrollView {
                    LazyVStack {
                        ForEach(0..<100, id: \.self) { number in
                            Text("Строка \(number)")
                                .frame(height: 50)
                                .id(number)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TestScroll()
}
