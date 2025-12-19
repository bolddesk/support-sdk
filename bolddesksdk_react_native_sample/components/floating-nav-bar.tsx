"use client";
import { View, Text, TouchableOpacity, Image } from "react-native";
import styles from "../styles/floating-nav-styles";
import { IMAGES } from "../constants/constants";

export default function FloatingNavBar({
  activeTab,
  onChange,
}: {
  activeTab: string;
  onChange: (tab: string) => void;
}) {
  return (
    <View style={styles.navContainer}>
      <NavItem
        label="Home"
        icon={IMAGES.HOME_ICON}
        isActive={activeTab === "home"}
        onPress={() => onChange("home")}
        showRed={false}
      />

      <NavItem
        label="Chat"
        icon={IMAGES.CHAT}
        isActive={activeTab === "chat"}
        onPress={() => onChange("chat")}
        showRed={true}
      />

      <NavItem
        label="Help"
        icon={IMAGES.HELP}
        isActive={activeTab === "help"}
        onPress={() => onChange("help")}
        showRed={true}
      />

      <NavItem
        label="Profile"
        icon={IMAGES.PROFILE_ICON}
        isActive={activeTab === "profile"}
        onPress={() => onChange("profile")}
        showRed={false}
      />
    </View>
  );
}


function NavItem({
  label,
  icon,
  isActive,
  onPress,
  showRed = false,
}: {
  label: string;
  icon: any;
  isActive: boolean;
  onPress: () => void;
  showRed?: boolean;
}) {
  return (
    <TouchableOpacity style={styles.item} onPress={onPress}>
      <View style={styles.iconWrapper}>
        <Image
          source={icon}
          style={[styles.icon, isActive && { tintColor: "#7C3AED" }]}
        />

        {showRed && <View style={styles.redDot} />}
      </View>

      <Text
        style={[
          styles.label,
          isActive && { color: "#7C3AED", fontWeight: "600" },
        ]}
      >
        {label}
      </Text>
    </TouchableOpacity>
  );
}
