//
//  MyWidget.swift
//  MyWidget
//
//  Created by Thomas Dye on 6/26/25.
//
import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct MyWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.emoji)
        }
    }
}

struct MyNormalWidget: Widget {
    let kind: String = "MyNormalWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
                .containerBackground(.clear, for: .widget)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MyClearWidget: Widget {
    let kind: String = "MyClearWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
                .containerBackground(.clear, for: .widget)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MyBlurWidget: Widget {
    let kind: String = "MyBlurWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
                .containerBackground(.clear, for: .widget)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct AnalogClockWidget: Widget {
    let kind: String = "MyClearWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EntryView(entry: entry)
        }
        .configurationDisplayName("Analog Clock Widget")
        .description("Display an analog clock that animates the rotation of its hands.")
//        .supportedFamilies([.systemSmall])
    }
}


import ClockRotationEffect
import SwiftUI

extension AnalogClockWidget {
    struct EntryView: View {
        let entry: SimpleEntry

        var body: some View {
            contentView
        }
    }
}

// MARK: - Content

extension AnalogClockWidget.EntryView {
    private var contentView: some View {
        ZStack {
            faceView
            hourHandView
            minuteHandView
            secondHandView
            knobView
        }
    }

    private var faceView: some View {
        Circle()
            .fill(.background)
            .stroke(.gray)
            .frame(width: 200, height: 200)
            .frame(maxWidth: .infinity)
    }

    private var hourHandView: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(gradient())
            .frame(width: 4, height: 50)
            .clockRotation(.hourHand)
    }

    private var minuteHandView: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(gradient())
            .frame(width: 3, height: 170)
            .clockRotation(.miniuteHand)
    }

    private var secondHandView: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(gradient())
            .frame(width: 2, height: 190)
            .clockRotation(.secondHand)
    }

    private var knobView: some View {
        Circle()
            .fill(.brown)
            .frame(width: 3, height: 3)
    }
}

// MARK: - Helpers

extension AnalogClockWidget.EntryView {
    private func gradient() -> LinearGradient {
        .init(
            gradient: .init(
                stops: [
                    .init(color: .brown, location: 0.5),
                    .init(color: .clear, location: 0.5)
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

extension View {
    fileprivate func clockRotation(_ period: ClockRotationPeriod) -> some View {
        modifier(
            ClockRotationModifier(
                period: period,
                timezone: .current,
                anchor: .center
            )
        )
    }
}

extension AnalogClockWidget {
    struct Entry: TimelineEntry {
        var date: Date = .now
    }
}

// MARK: - Data

extension AnalogClockWidget.Entry {
    static var placeholder: Self {
        .init()
    }
}

#Preview(as: .systemMedium) {
    AnalogClockWidget()
} timeline: {
    AnalogClockWidget.Entry.placeholder
}

