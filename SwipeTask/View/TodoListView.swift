//
//  TodoListView.swift
//  SwipeTask
//
//  Created by Nils on 3/28/24.
//

import SwiftUI

struct TodoListView: View {
    @State var todoItems : [TodoItemModel] = [
        TodoItemModel(title: "Hello", timeSpend: "00:00:00", dueDate: "Today", priority: 90, completed: false, completedDate: ""),
        TodoItemModel(title: "World", timeSpend: "00:00:00", dueDate: "Today", priority: 90, completed: false, completedDate: ""),
        TodoItemModel(title: "!", timeSpend: "00:00:00", dueDate: "Today", priority: 90, completed: false, completedDate: ""),
        TodoItemModel(title: "Das hier ist ein langer text, um die größe des Feldes zu überschreiten.", timeSpend: "00:00:00", dueDate: "Today", priority: 90, completed: false, completedDate: ""),
    ]
    var body: some View {
        HStack {
            Text("Todos").font(Font.system(size: 30)).bold()
            Spacer()
            Button("+", action: {}).font(Font.system(size: 35)).padding(.horizontal, 10).background(Color.accentColor).foregroundColor(Color.primary).cornerRadius(10)
        }.padding()
        ScrollView {
            ForEach(todoItems) {
                todo in
                TodoView(title: todo.title, time: todo.timeSpend, dueDate: todo.dueDate)
            }
        }
    }
}

struct TodoView: View {
    var title: String
    var time: String
    var dueDate: String
    
    @State var saturation: CGFloat = 0.0
    
    var body: some View {
        VStack{
            text_title
            HStack {
                Text("Move")
                Spacer()
                Text(time)
                Spacer()
                Text(dueDate)
                icon_priority
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 2.5)
        .background(Color.gray)
        .cornerRadius(10)
        .padding(.horizontal, 5)
        .onTapGesture(count: 2, perform: doubleTapAction)
        .onTapGesture(perform: singleTapAction)
        .onLongPressGesture(minimumDuration: 1, perform: longPressAction)
        .gesture(dragGesture())
    }
    
    var text_title: some View {
        Text(title)
            .bold()
            .lineLimit(1)
            .padding(.vertical, 2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
    }

    var icon_priority: some View {
        Text("")
            .frame(width: 30, height: 30)
            .background(Color.red.saturation(saturation))
            .cornerRadius(100)
    }
    
    func doubleTapAction() {
        print(title + " Todo got DoubleTapped")
    }
    
    func singleTapAction() {
        print(title + " Todo got Tapped")
    }
    
    func longPressAction() {
        print(title + " Todo got held")
    }
    
    func dragGesture() -> some Gesture {
        LongPressGesture(minimumDuration: 0.3).sequenced(before: DragGesture(minimumDistance: 10.0, coordinateSpace: .local)
            .onChanged { amount in
                saturation = map_value(value: abs(amount.translation.width), minInput: 40, maxInput: 300, minOutput: 0.0, maxOutput: 0.9)
            }
            .onEnded { amount in
                print("Todo LongPress Drag Gesture")
                saturation = map_value(value: abs(amount.translation.width), minInput: 40, maxInput: 300, minOutput: 0.0, maxOutput: 0.9)
            })
    }
}


func map_value(value: Double, minInput: Double, maxInput:Double, minOutput: Double, maxOutput: Double) -> Double {
    
    let mapped = minOutput + (maxOutput - minOutput) * (value - minInput) / (maxInput - minInput);
    return clamp(value:mapped, min: minOutput, max: maxOutput)
}

func clamp(value: Double, min: Double, max: Double) -> Double {
    return Swift.min(Swift.max(value, min), max)
}

#Preview {
    TodoListView()
}
