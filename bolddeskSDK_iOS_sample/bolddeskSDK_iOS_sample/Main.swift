import SwiftUI
import BolddeskSupportSDK

struct Main: View {
    var body: some View {
        Button("Show Home") {
            BolddeskSDK.applyDefaultFont = true
            BolddeskSDK.applyTheme(accentColor: "#800080", primaryColor: "#008000")
            BolddeskSDK.setPreferredTheme(SDKTheme.system)
            BolddeskSDK.showHome()
        }
        Button("Show KB") {
            BolddeskSDK.applyTheme(accentColor: "#800080", primaryColor: "#008000")
            BolddeskSDK.showKB()
        }
        Button("Show KB") {
            BolddeskSDK.applyTheme(accentColor: "#800080", primaryColor: "#008000")
            BolddeskSDK.showSubmitTicket()
        }
    }
}

