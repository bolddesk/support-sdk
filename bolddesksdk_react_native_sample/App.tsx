import React, { useEffect } from "react";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { SafeAreaProvider, SafeAreaView } from "react-native-safe-area-context";
import { enableScreens } from "react-native-screens";
import ProfileScreen from "./components/profile";
import Investment from "./components/investment";
import Home from "./components/home";
import BoldDeskSupportSDK from "bd-support-sdk-react-native";
import { loginWithJwtIfNeeded } from "./Auth";

enableScreens();

const Stack = createNativeStackNavigator();

export default function App() {

  useEffect(() => {
  const initApp = async () => {
    try {
      await BoldDeskSupportSDK.initialize(
        "YOUR_APP_ID",
        "YOUR_BRAND_URL",
        async () => {
          console.log("✅ Initialized successfully")
          await loginWithJwtIfNeeded(
            "YOUR_SECRET_KEY",
            "YOUR_MAIL_ID"
          );
        },
        (error) => console.log("Init error:", error)
      );
    } catch (e) {
      console.error("App init failed", e);
    }
  };

  initApp();
}, []);

  return (
    <SafeAreaProvider>
      <SafeAreaView style={{ flex: 1 }} edges={["top", "bottom"]}>
        <NavigationContainer>
          <Stack.Navigator
            screenOptions={{ headerShown: false }}
            initialRouteName="Home"
          >
            <Stack.Screen name="Home" component={Home} />
            <Stack.Screen name="Profile" component={ProfileScreen} />
            <Stack.Screen name="Investment" component={Investment} />
          </Stack.Navigator>
        </NavigationContainer>
      </SafeAreaView>
    </SafeAreaProvider>
  );
}
