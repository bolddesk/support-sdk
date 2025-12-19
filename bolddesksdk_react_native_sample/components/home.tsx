import React from "react";
import { View } from "react-native";
import { useNavigation } from "@react-navigation/native";
import FinanceManagement from "./finance-management";
import FloatingNavBar from "./floating-nav-bar";
import BoldDeskSupportSDK from "bd-support-sdk-react-native";

export default function Home() {
    const navigation = useNavigation();
    return (
        <View style={{ flex: 1 }}>
            <FinanceManagement />
            <FloatingNavBar
                activeTab="home"
                onChange={(tab: string) => {
                    if (tab === "help") {
                        BoldDeskSupportSDK.showHome()
                    } else if (tab === "profile") {
                        // @ts-ignore - navigation type inferred for simplicity
                        navigation.navigate("Profile");
                    } else {
                        console.log("Selected Tab:", tab);
                    }
                }}
            />
        </View>
    );
}
