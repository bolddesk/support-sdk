import { useState } from "react";
import { View, Text, ScrollView, Image, TouchableOpacity } from "react-native";
import { ImageSourcePropType } from "react-native"; // For better typing of image sources
import styles from "../styles/finance-styles";
import { IMAGES } from "../constants/constants";
import { useNavigation } from "@react-navigation/native";

// Define the stock item type
interface Stock {
  name: string;
  price: string;
  gain?: string;
  miniChart: ImageSourcePropType;
}

// Define the period type for type safety
type Period = "1D" | "1W" | "1M";

// Define the shape of each period's data
interface PeriodData {
  overallGain: number;
  chartImage: ImageSourcePropType;
  stocks: Stock[];
  arrow: string;
  arrowColor: string;
}

// Mock data for each period (replace with real API data in production)
const PERIOD_DATA: Record<Period, PeriodData> = {
  "1D": {
    overallGain: -0.07,
    chartImage: IMAGES.DAY_CHART,
    stocks: [
      { name: "Vordex Inc.", price: "$145.25", gain: "+0.19%", miniChart: IMAGES.APPLE_STOCK },
      { name: "EchoForge Inc.", price: "$92.16", gain: "-0.12%", miniChart: IMAGES.TESLA_STOCK },
      { name: "PulseNet.com", price: "$58.42", gain: "0.10%", miniChart: IMAGES.AMAZON_STOCK },
      { name: "AstraLogix Inc.", price: "$207.60", gain: "-0.43%", miniChart: IMAGES.NETFLIX_STOCK },
    ],
    arrow: "↓",
    arrowColor: "red",
  },
  "1W": {
    overallGain: 0.27,
    chartImage: IMAGES.WEEK_CHART,
    stocks: [
      { name: "Vordex Inc.", price: "$144.75", gain: "+0.34%", miniChart: IMAGES.AMAZON_STOCK },
      { name: "EchoForge Inc.", price: "$93.41", gain: "+0.34%", miniChart: IMAGES.NETFLIX_STOCK },
      { name: "PulseNet.com", price: "$57.94", gain: "+0.10%", miniChart: IMAGES.TESLA_STOCK },
      { name: "AstraLogix Inc.", price: "$211.03", gain: "+0.28%", miniChart: IMAGES.APPLE_STOCK },
    ],
    arrow: "↑",
    arrowColor: "green",
  },
  "1M": {
    overallGain: 1.07,
    chartImage: IMAGES.MONTH_CHART,
    stocks: [
      { name: "Vordex Inc.", price: "$144.75", gain: "+0.34%", miniChart: IMAGES.NETFLIX_STOCK },
      { name: "EchoForge Inc.", price: "$93.41", gain: "+0.34%", miniChart: IMAGES.APPLE_STOCK },
      { name: "PulseNet.com", price: "$57.94", gain: "+0.10%", miniChart: IMAGES.AMAZON_STOCK },
      { name: "AstraLogix Inc.", price: "$211.03", gain: "+0.28%", miniChart: IMAGES.TESLA_STOCK },
    ],
    arrow: "↑",
    arrowColor: "green",
  },
};

export default function FinanceManagement() {
  const navigation = useNavigation();
  const [showBalance, setShowBalance] = useState(false);
  const [selectedPeriod, setSelectedPeriod] = useState<Period>("1D");

  // Get current period data (now fully typed and safe)
  const currentData = PERIOD_DATA[selectedPeriod];

  const FEATURES = [
    { icon: IMAGES.SAVINGS_ICON, title: "Savings", sub: "Earn 2% APY" },
    { icon: IMAGES.INVEST_ICON, title: "Invest", sub: "Stocks & Bonds" },
    { icon: IMAGES.BITCOIN_ICON, title: "Buy Bitcoin", sub: "Secure Platform" },
    { icon: IMAGES.TAXFILING_ICON, title: "Tax Filing", sub: "Maximize Refund" },
  ];

  return (
    <ScrollView style={styles.pageContainer} showsVerticalScrollIndicator={false}>
      <View style={styles.paddingHorizontal}>
        <Text style={styles.pageTitle}>Finance Management</Text>

        {/* BALANCE CARD */}
        <View style={styles.balanceCard}>
          <View style={styles.balanceHeader}>
            <Text style={styles.balanceLabel}>Account Balance</Text>
            <TouchableOpacity onPress={() => setShowBalance(!showBalance)}>
              <Text style={styles.showText}>{showBalance ? "Hide" : "Show"}</Text>
            </TouchableOpacity>
          </View>
          <Text style={styles.balanceAmount}>
            {showBalance ? "$12,345.67" : "$**********"}
          </Text>
          <View style={styles.buttonRow}>
            <TouchableOpacity style={styles.addMoneyButton}>
              <Text style={styles.addMoneyText}>Add money</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.withdrawButton}>
              <Text style={styles.withdrawText}>Withdraw</Text>
            </TouchableOpacity>
          </View>
        </View>

        {/* FEATURE GRID */}
        <View style={styles.featureGrid}>
          {FEATURES.map(({ icon, title, sub }, i) => (
            <TouchableOpacity
              key={i}
              onPress={() => {
                // @ts-ignore - navigation type inferred for simplicity
                navigation.navigate("Investment");
              }}
            >
              <View style={styles.featureCard}>
                <Image source={icon} style={styles.featureIcon} resizeMode="contain" />
                <Text style={styles.featureTitle}>{title}</Text>
                <Text style={styles.featureSubtitle}>{sub}</Text>
              </View>
            </TouchableOpacity>
          ))}
        </View>

        {/* Dynamic Gains Header */}
        <Text style={styles.todaysGainsTitle}>
          {selectedPeriod === "1D" ? "Today's Gains" : selectedPeriod === "1W" ? "This Week's Gains" : "This Month's Gains"}
        </Text>
        <View style={styles.gainRow}>
          <Text style={{ ...styles.gainArrow, color: currentData.arrowColor }}>
            {currentData.arrow}
          </Text>
          <Text style={{ ...styles.gainPercent, color: currentData.arrowColor }}>
            {currentData.overallGain > 0 ? "+" : ""}
            {currentData.overallGain}%
          </Text>
          <Text style={styles.gainLabel}>
            {selectedPeriod === "1D" ? " Today" : selectedPeriod === "1W" ? " This Week" : " This Month"}
          </Text>
        </View>

        {/* PERIOD SELECTOR */}
        <View style={styles.periodSelector}>
          {(["1D", "1W", "1M"] as const).map((p) => (
            <TouchableOpacity
              key={p}
              onPress={() => setSelectedPeriod(p)}
              style={[
                styles.periodButton,
                p === selectedPeriod && styles.periodButtonActive,
              ]}
            >
              <Text
                style={[
                  styles.periodText,
                  p === selectedPeriod && styles.periodTextActive,
                ]}
              >
                {p}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      {/* Dynamic Chart */}
      <Image source={currentData.chartImage} style={styles.chartImage} />

      <View style={styles.paddingHorizontal}>
        {/* STOCK SECTION */}
        <View style={styles.stocksHeaderRow}>
          <View style={{ flex: 1 }}>
            <Text style={styles.sectionTitle}>Stocks</Text>
            <Text style={styles.stocksSubtitle}>Performance</Text>
          </View>
          <Image source={IMAGES.ARROW_RIGHT} style={{ width: 18, height: 18 }} />
        </View>

        <View style={styles.stockGrid}>
          {currentData.stocks.map(({ name, price, gain, miniChart }, i) => (
            <View key={i} style={styles.stockCard}>
              <Text style={styles.stockName}>{name}</Text>
              <Text style={styles.stockPrice}>{price}</Text>
              <Image source={miniChart} style={styles.miniChart} />
              {gain && (
                <Text
                  style={[
                    gain.includes("+") ? styles.stockGainPositive : styles.stockGainNegative,
                  ]}
                >
                  {gain}
                </Text>
              )}
            </View>
          ))}
        </View>
      </View>

      <View style={{ height: 100 }} />
    </ScrollView>
  );
}