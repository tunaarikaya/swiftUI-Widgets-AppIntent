//
//  ToDoWidget.swift
//  ToDoWidget
//
//  Created by Mehmet Tuna Arıkaya on 11.09.2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ToDoEntry {
        ToDoEntry(toDoToDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
    }

    func getSnapshot(in context: Context, completion: @escaping (ToDoEntry) -> ()) {
        let entry = ToDoEntry(toDoToDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ToDoEntry>) -> ()) {
        let toDisplay = Array(SharedDatas.shared.toDos.prefix(3))
        let timeline = Timeline(entries: [ToDoEntry(toDoToDisplay: toDisplay)], policy: .atEnd)
        completion(timeline)
    }
}

struct ToDoEntry: TimelineEntry {
    let date: Date = .now
    var toDoToDisplay: [ToDo]
}

struct ToDoWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("To-Do List")
                .font(.headline.italic())
                .padding(.bottom, 5)
                .foregroundColor(.blue)
                
            
            ForEach(entry.toDoToDisplay.prefix(3)) { toDo in
                HStack {
                    Text(toDo.name)
                        .strikethrough(toDo.isDone)
                       
                    
                    Spacer()
                    
                    Image(systemName: toDo.isDone ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(toDo.isDone ? .green : .orange)
                        .frame(width: 20, height: 20)
                }
                .padding(8)
                .background(Color.white)
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ToDoWidget: Widget {
    let kind: String = "ToDoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ToDoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("To-Do Widget")
        .description("This widget shows your top 3 To-Do items.")
    }
}

#Preview(as: .systemSmall) {
    ToDoWidget()
} timeline: {
    ToDoEntry(toDoToDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
}
