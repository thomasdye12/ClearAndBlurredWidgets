//
//  MyWidgetBundle.swift
//  MyWidget
//
//  Created by Thomas Dye on 6/26/25.
//

import WidgetKit
import SwiftUI

@main
struct MyWidgetBundle: WidgetBundle {
    init() {}
    
    @WidgetBundleBuilder
    var body: some Widget {
        MyNormalWidget()
        MyClearWidget()
        MyBlurWidget()
        AnalogClockWidget()
    }
}
