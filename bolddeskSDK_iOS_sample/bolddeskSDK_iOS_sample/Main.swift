//
//  ContentView.swift
//  sample-ios-app
//
//  Created by mohammedismailsameer on 14/08/25.
//

import BoldDeskSupportSDK
import CryptoKit
import Foundation
import SwiftJWT
import SwiftUI

// MARK: - Adaptive Colors
extension Color {
    static var adaptivePrimaryText: Color { Color(UIColor.label) }
    static var adaptiveSecondaryBackground: Color {
        Color(UIColor.systemBackground)
    }
    static var adaptiveFieldBorder: Color { Color(UIColor.separator) }
}

// MARK: - Main View
struct Main: View {
    var body: some View {
        LoginView()
    }
}

// MARK: - Login View
struct LoginView: View {
    @State private var appId = ""
    @State private var brandUrl = ""
    @State private var serverKey = ""
    @State private var clientEmail = ""

    @State private var selectedFont = "Inter"
    @State private var selectedTheme: SDKThemeType = .system
    @State private var selectedAppBarColor: String = ""
    @State private var selectedButtonColor: String = ""
    
    @State private var loginSeccossMessage: String = ""
    @State private var initializedText: String = ""

    @State private var isLoading = false
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isErrorToast = false

    let fonts = ["Inter", "Roboto", "Poppins", "Times New Roman", "Open Sans"]
    let themes: [SDKThemeType] = [.system, .light, .dark]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                Text("LOGIN")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.adaptivePrimaryText)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Initialize:")
                        .font(.headline)
                        .foregroundColor(.adaptivePrimaryText)

                    StyledTextField(placeholder: "App ID", text: $appId)
                    StyledTextField(placeholder: "Brand URL", text: $brandUrl)
                    Button(action: {
                        isLoading = true
                        BDSupportSDK.enableLogging()
                        BDSupportSDK.initialize(
                            appId: appId,
                            brandURl: brandUrl,
                            { success in
                                isLoading = false
                                toastMessage = success ?? "Initialized successfully!"
                                isErrorToast = false
                                showToastWithAutoHide()
                            },
                            { error in
                                isLoading = false
                                toastMessage = error ?? "Initialization failed!"
                                isErrorToast = true
                                showToastWithAutoHide()
                            }
                        )
                    }) {
                        Label("initialize", systemImage: "book.fill")
                            .buttonStyleModifier()
                    }
                    Text(initializedText)
                }
                .padding(.top)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Login:")
                        .font(.headline)
                        .foregroundColor(.adaptivePrimaryText)

                    StyledTextField(placeholder: "Server Key", text: $serverKey)
                    StyledTextField(
                        placeholder: "Client Email",
                        text: $clientEmail
                    )
                }

                ThemeSection(
                    title: "AppBar Theme:",
                    selectedColor: $selectedAppBarColor
                )
                ThemeSection(
                    title: "Button Theme:",
                    selectedColor: $selectedButtonColor
                )

                VStack(alignment: .leading, spacing: 12) {
                    Text("Font Family:")
                        .font(.headline)
                        .foregroundColor(.adaptivePrimaryText)

                    StyledPicker(selection: $selectedFont, options: fonts)

                    Text("App Theme:")
                        .font(.headline)
                        .foregroundColor(.adaptivePrimaryText)

                    ThemePicker(selection: $selectedTheme, options: themes)
                }

                VStack(spacing: 15) {
                    Button(action: jwt) {
                        Label("Login", systemImage: "book.fill")
                            .buttonStyleModifier()
                    }
                    
                    Text(loginSeccossMessage)

                    Button(action: {
                        BDSupportSDK.logout()
                    }) {
                        Label("Log Out", systemImage: "book.fill")
                            .buttonStyleModifier()
                    }

                    Button(action: openHome) {
                        Label("Open Home Screen", systemImage: "house.fill")
                            .buttonStyleModifier()
                    }

                    Button(action: openCreateTicket) {
                        Label(
                            "Open Create Ticket",
                            systemImage: "plus.circle.fill"
                        )
                        .buttonStyleModifier()
                    }

                    Button(action: openKB) {
                        Label("Open KB", systemImage: "book.fill")
                            .buttonStyleModifier()
                    }

                }
                .padding(.top, 30)
            }
            .padding()
        }
        .background(Color.adaptiveSecondaryBackground)
        .overlay(
            Group {
                if isLoading {
                    LoadingOverlay()
                }
                
                if showToast {
                    VStack {
                        Spacer()
                        ToastView(message: toastMessage, isError: isErrorToast)
                    }
                    .animation(.easeInOut, value: showToast)
                    .transition(.move(edge: .bottom))
                }
            }
        )
        
        
    }

    func jwt() {
        if BDSupportSDK.isLoggedIn() {
            toastMessage = "Already user logged in."
            isErrorToast = false
            showToastWithAutoHide()
            return
        }
        isLoading = true
        var jwtToken: String = ""
        do {
            jwtToken = try generateJwt(
                userEmail: clientEmail,
                secretKey: serverKey,
                name: "boomi balan"
            )
            print("Generated JWT Token: \(jwtToken)")
        } catch {
            isLoading = false
            toastMessage = "Failed to generate JWT"
            isErrorToast = true
            showToastWithAutoHide()
            return
        }
        BDSupportSDK.loginWithJWTToken(jwtToken: jwtToken, { success in
            isLoading = false
            toastMessage = success ?? "Login successful!"
            isErrorToast = false
            showToastWithAutoHide()
        }, { error in
            isLoading = false
            toastMessage = error ?? "Login failed!"
            isErrorToast = true
            showToastWithAutoHide()
        })
    }

    func openHome() {
        initializeSDK()
        BDSupportSDK.showHomeDashboard()
    }
    func openCreateTicket() {
        initializeSDK()
        BDSupportSDK.showCreateTicket()
    }
    func openKB() {
        initializeSDK()
        BDSupportSDK.showKB()
    }

    func initializeSDK() {
        BDSupportSDK.applyTheme(
            accentColor: selectedButtonColor,
            primaryColor: selectedAppBarColor
        )
        BDSupportSDK.setPreferredTheme(
            selectedTheme == .system
                ? .system : (selectedTheme == .light ? .light : .dark)
        )
        BDPortalConfiguration.customFontName = selectedFont
    }

    
    private func showToastWithAutoHide() {
        withAnimation {
            showToast = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showToast = false
            }
        }
    }
}

// MARK: - Theme Enum
enum SDKThemeType: String, CaseIterable, Identifiable {
    case system = ".system"
    case light = ".light"
    case dark = ".dark"

    var id: String { rawValue }
    var displayName: String {
        switch self {
        case .system: return "System Default"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

}

// MARK: - Theme Picker
struct ThemePicker: View {
    @Binding var selection: SDKThemeType
    var options: [SDKThemeType]

    var body: some View {
        Menu {
            ForEach(options) { option in
                Button(action: { selection = option }) {
                    HStack {
                        Text(option.displayName)
                        if option == selection {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack {
                Text(selection.displayName)
                    .foregroundColor(.adaptivePrimaryText)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.adaptiveFieldBorder, lineWidth: 1)
            )
        }
    }

}

// MARK: - ThemeSection (color picker)
struct ThemeSection: View {
    var title: String
    @Binding var selectedColor: String

    let colorMap: [(color: Color, hex: String)] = [
        (.blue, "#007AFF"),
        (.green, "#34C759"),
        (.yellow, "#FFCC00"),
        (.orange, "#FF9500"),
        (.purple, "#AF52DE"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.adaptivePrimaryText)
            HStack {
                ForEach(colorMap, id: \.hex) { pair in
                    Circle()
                        .fill(pair.color)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Circle()
                                .stroke(
                                    selectedColor == pair.hex
                                        ? Color.adaptivePrimaryText
                                        : Color.clear,
                                    lineWidth: 3
                                )
                        )
                        .onTapGesture {
                            selectedColor = pair.hex
                        }
                }
            }
        }
    }

}

// MARK: - StyledTextField
struct StyledTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .font(.system(size: 16))
            .foregroundColor(.adaptivePrimaryText)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.adaptiveFieldBorder, lineWidth: 1)
            )
    }

}

// MARK: - StyledPicker
struct StyledPicker: View {
    @Binding var selection: String
    var options: [String]

    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(action: { selection = option }) {
                    Text(option)
                }
            }
        } label: {
            HStack {
                Text(selection)
                    .foregroundColor(.adaptivePrimaryText)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.adaptiveFieldBorder, lineWidth: 1)
            )
        }
    }
}

// MARK: - Button Modifier
extension Label where Title == Text, Icon == Image {
    func buttonStyleModifier() -> some View {
        self
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.purple)
            .cornerRadius(10)
    }
}

struct ToastView: View {
    let message: String
    let isError: Bool
    
    var body: some View {
        Text(message)
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(isError ? Color.red.opacity(0.9) : Color.green.opacity(0.9))
            .cornerRadius(10)
            .shadow(radius: 5)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .padding(.bottom, 40)
    }
}

struct LoadingOverlay: View {
    var body: some View {
        ZStack {
            Color.primary.opacity(0.2)
                .edgesIgnoringSafeArea(.all)

            ProgressView()
                .progressViewStyle(
                    CircularProgressViewStyle(tint: .accentColor)
                )
                .scaleEffect(1.5)
        }
    }
}

// MARK: - JWT Helper
struct MyClaims: Claims {
    let email: String
    let name: String
    let iat: Date
    let exp: Date
}

func generateJwt(userEmail: String, secretKey: String, name: String) throws
    -> String
{
    let currentTime = Date()
    let expirationTime = currentTime.addingTimeInterval(5 * 60)  // 5 minutes

    let claims = MyClaims(
        email: userEmail,
        name: name,
        iat: currentTime,
        exp: expirationTime
    )

    var jwt = JWT(claims: claims)
    let signer = JWTSigner.hs256(key: Data(secretKey.utf8))
    let signedToken = try jwt.sign(using: signer)

    return signedToken
}
