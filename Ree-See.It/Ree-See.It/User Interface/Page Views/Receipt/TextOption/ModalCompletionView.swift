//
//  ModalCompletionView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/11/23.
//

import SwiftUI

struct ModalCompletionView: View {
    /// show the submission view when `Continue` is pressed.
    @Binding var showSubmission: Bool
    
    // Internal State
    @State private var isAnimating: Bool = false
    @State private var second: Int = 0 // keep track of how many seconds the view has been appeared
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 4)
                .foregroundColor(.clear)
            
            VStack(alignment: .center) {
                HStack {
                    Circle()
                        .frame(width: 80)
                        .foregroundColor(.gray)
                        .overlay {
                            Image(systemName: "checkmark")
                                .fontWeight(.bold)
                                .font(.system(size: 40))
                                .foregroundColor(.green)
                                .blur(radius: isAnimating ? 0 : 3.0)
                                .scaleEffect(isAnimating ? 1 : 0.25)
                                .opacity(isAnimating ? 1 : 0)
                        }
                }
                
                
                Text("Your order has been submitted!")
                    .font(.system(size: 18))
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                
            }
        }
        .frame(maxWidth: 150, maxHeight: 150) // make the view to be a square
        .padding()
        .onAppear {
            withAnimation(.linear(duration: 0.5)) {
                isAnimating.toggle()
            }
        }
        .onTapGesture {
            showSubmission.toggle()
        }
        .onReceive(timer) { _ in
            if second == 2 {
                showSubmission.toggle()
                timer.upstream.connect().cancel()
            }
            second += 1
        }
        
    }
}

#Preview {
    ModalCompletionView(showSubmission: .constant(true))
}
