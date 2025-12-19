import { useColorScheme } from "react-native";
import { useMemo } from "react";

export type ColorScheme = "light" | "dark";

export const lightTheme = {
  // Primary Colors
  primary: "#7C3AED",
  primaryLight: "#F9F5FF",
  
  // Text Colors
  textPrimary: "#101828",
  textSecondary: "#344054",
  textTertiary: "#475467",
  textLight: "#667085",
  textLightest: "#98A2B3",
  
  // Background Colors
  background: "#ffffff",
  backgroundSecondary: "#F9FAFB",
  backgroundTertiary: "#F3F4F6",
  backgroundQuaternary: "#F2F4F7",
  
  // Border Colors
  borderPrimary: "#E5E7EB",
  borderSecondary: "#EAECF0",
  
  // Status Colors
  success: "#16A34A",
  successLight: "#079455",
  successDark: "#6941C6",
  
  // Danger/Error
  danger: "#D92D20",
  
  // Special Colors
  purple: "#6941C6",
  purpleLight: "#E9D7FE",
  purpleLightest: "#F9F5FF",
  
  // Card & Shadow
  shadowColor: "rgba(16, 24, 40, 1)",
  cardBackground: "#ffffff",
  
  // Semantic Colors
  reward: "#C11574",
  rewardBackground: "#fde4ef",
  refer: "#026AA2",
  referBackground: "#e0f2fe",
  
  // Button Colors
  buttonPrimary: "#7C3AED",
  buttonPrimaryText: "#ffffff",
  buttonSecondary: "#ffffff",
  buttonSecondaryText: "#7C3AED",
  buttonSecondaryBorder: "#E5E7EB",
  
  // Chart Colors
  chartLine1: "#6366f1",
  chartLine2: "#c7b7ff",
  chartGreen: "#079455",
  
  // Icon Colors
  iconColor: "#667085",
  iconColorActive: "#7C3AED",
};

export const darkTheme = {
  // Primary Colors
  primary: "#9F7AEA",
  primaryLight: "#2D1B4E",
  
  // Text Colors
  textPrimary: "#F3F4F6",
  textSecondary: "#E5E7EB",
  textTertiary: "#D1D5DB",
  textLight: "#9CA3AF",
  textLightest: "#6B7280",
  
  // Background Colors
  background: "#111827",
  backgroundSecondary: "#1F2937",
  backgroundTertiary: "#374151",
  backgroundQuaternary: "#2D3748",
  
  // Border Colors
  borderPrimary: "#374151",
  borderSecondary: "#4B5563",
  
  // Status Colors
  success: "#34D399",
  successLight: "#6EE7B7",
  successDark: "#B794F6",
  
  // Danger/Error
  danger: "#F87171",
  
  // Special Colors
  purple: "#B794F6",
  purpleLight: "#5A3E84",
  purpleLightest: "#2D1B4E",
  
  // Card & Shadow
  shadowColor: "rgba(0, 0, 0, 0.4)",
  cardBackground: "#1F2937",
  
  // Semantic Colors
  reward: "#EC4899",
  rewardBackground: "#5B1C3D",
  refer: "#0EA5E9",
  referBackground: "#0C3D5C",
  
  // Button Colors
  buttonPrimary: "#9F7AEA",
  buttonPrimaryText: "#ffffff",
  buttonSecondary: "#1F2937",
  buttonSecondaryText: "#9F7AEA",
  buttonSecondaryBorder: "#4B5563",
  
  // Chart Colors
  chartLine1: "#A78BFA",
  chartLine2: "#7C3AED",
  chartGreen: "#6EE7B7",
  
  // Icon Colors
  iconColor: "#F3F4F6",
  iconColorActive: "#9F7AEA",
};

export type ThemeColors = typeof lightTheme;

export const useThemeColors = (): ThemeColors => {
  const colorScheme = useColorScheme();
  
  return useMemo(() => {
    return colorScheme === "dark" ? darkTheme : lightTheme;
  }, [colorScheme]);
};

export const getThemeColors = (colorScheme: ColorScheme | null | undefined): ThemeColors => {
  return colorScheme === "dark" ? darkTheme : lightTheme;
};
