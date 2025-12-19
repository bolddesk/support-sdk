import { useState } from "react";
import { useNavigation } from "@react-navigation/native";
import { View, Text, ScrollView, Image, TouchableOpacity } from "react-native";
import styles from "../styles/investment-styles";
import financestyles from "../styles/finance-styles";
import { IMAGES } from "../constants/constants";

type Period = "1D" | "1W" | "1M";

interface Stock {
  ticker: string;
  shares: number;
}

interface Stats {
  totalGain: string;
  totalLoss: string;
  netGain: string;
  bestPerformer: string;
  worstPerformer: string;
  averageGain: string;
  averageLoss: string;
  totalVolume: string;
  highestVolume: string;
  lowestVolume: string;
}

interface PeriodData {
  stocks: Stock[];
  totalValue: string;
  totalGain: string;
  changeLabel: string;
  changeValue: string;
  changeGain: string;
  volumeLabel: string;
  volumeValue: string;
  stats: Stats;
}

// Add this object near the top, after positionData
const periodGains: Record<Period, {
  mainLabel: string;
  mainGain: string;
  specificLabel: string;
  specificGain: string;
}> = {
  "1D": {
    mainLabel: "Today",
    mainGain: "1.2%",
    specificLabel: "Today",
    specificGain: "0.8%",
  },
  "1W": {
    mainLabel: "This Week",
    mainGain: "3.8%",
    specificLabel: "This Week",
    specificGain: "2.6%",
  },
  "1M": {
    mainLabel: "This Month",
    mainGain: "8.4%",
    specificLabel: "This Month",
    specificGain: "6.1%",
  },
};

const positionData: Record<Period, PeriodData> = {
  "1D": {
    stocks: [
      { ticker: "VTBX", shares: 50 },
      { ticker: "EFRG", shares: 10 },
      { ticker: "PNSY", shares: 5 },
      { ticker: "ALGX", shares: 20 },
    ],
    totalValue: "$10000",
    totalGain: "+1.2%",
    changeLabel: "Change Today",
    changeValue: "$120",
    changeGain: "+1.2%",
    volumeLabel: "Today's Volume",
    volumeValue: "500,000",
    stats: {
      totalGain: "$500",
      totalLoss: "$100",
      netGain: "$400",
      bestPerformer: "PNSY",
      worstPerformer: "VTBX",
      averageGain: "1.5%",
      averageLoss: "0.5%",
      totalVolume: "300",
      highestVolume: "PNSY",
      lowestVolume: "EFRG",
    },
  },
  "1W": {
    stocks: [
      { ticker: "VTBX", shares: 48 },
      { ticker: "EFRG", shares: 11 },
      { ticker: "PNSY", shares: 6 },
      { ticker: "ALGX", shares: 20 },
    ],
    totalValue: "$10150",
    totalGain: "+3.8%",
    changeLabel: "Change This Week",
    changeValue: "$380",
    changeGain: "+3.8%",
    volumeLabel: "This Week's Volume",
    volumeValue: "2,450,000",
    stats: {
      totalGain: "$1240",
      totalLoss: "$410",
      netGain: "$830",
      bestPerformer: "EFRG",
      worstPerformer: "VTBX",
      averageGain: "3.2%",
      averageLoss: "1.1%",
      totalVolume: "1820",
      highestVolume: "EFRG",
      lowestVolume: "PNSY",
    },
  },
  "1M": {
    stocks: [
      { ticker: "VTBX", shares: 52 },
      { ticker: "EFRG", shares: 12 },
      { ticker: "PNSY", shares: 5 },
      { ticker: "ALGX", shares: 19 },
    ],
    totalValue: "$10840",
    totalGain: "+8.4%",
    changeLabel: "Change This Month",
    changeValue: "$840",
    changeGain: "+8.4%",
    volumeLabel: "This Month's Volume",
    volumeValue: "9,800,000",
    stats: {
      totalGain: "$3510",
      totalLoss: "$980",
      netGain: "$2530",
      bestPerformer: "VTBX",
      worstPerformer: "ALGX",
      averageGain: "5.0%",
      averageLoss: "1.4%",
      totalVolume: "7120",
      highestVolume: "VTBX",
      lowestVolume: "PNSY",
    },
  },
};

export default function Investment() {
  const navigation = useNavigation();
  const [selectedPeriod, setSelectedPeriod] = useState<Period>("1D");
  const [selectedPeriod2, setSelectedPeriod2] = useState<Period>("1D");

  const HELP_ITEMS = [
    { label: "Trade Policy", icon: IMAGES.GLOBE_ICON },
    { label: "Payment Policy", icon: IMAGES.COINS_ICON },
    { label: "Account Policy", icon: IMAGES.USER_ICON },
  ];

  const currentData = positionData[selectedPeriod2];

  // Main chart (follows first period selector)
  const mainChart =
    selectedPeriod === "1D"
      ? IMAGES.DAY_CHART
      : selectedPeriod === "1W"
        ? IMAGES.WEEK_CHART
        : IMAGES.MONTH_CHART;

  // Specific chart (always different from main)
  const specificChart =
    selectedPeriod === "1D"
      ? IMAGES.WEEK_CHART
      : selectedPeriod === "1W"
        ? IMAGES.MONTH_CHART
        : IMAGES.DAY_CHART;

  return (
    <ScrollView style={styles.pageContainer} showsVerticalScrollIndicator={false}>
      {/* Header */}
      <View style={[financestyles.paddingHorizontal, { flexDirection: "row", alignItems: "center", height: 56 }]}>
        <TouchableOpacity style={styles.topRightMenu} onPress={() => navigation.goBack()}>
          <Image source={IMAGES.ARROW_RIGHT} style={[styles.icon24, { transform: [{ scaleX: -1 }] }]} />
        </TouchableOpacity>

        <Text style={[styles.pageTitle, { flex: 1, textAlign: 'center' }]}>Investment</Text>

        {/* Invisible spacer to balance the left back button */}
        <View style={styles.topRightMenu} />
      </View>

      {/* Main Gain + First Period Selector */}
      <View style={financestyles.paddingHorizontal}>
        <View style={styles.gainIndicator}>
          <Image source={IMAGES.BARCHART_ICON} style={{ width: 18, height: 18 }} />
          <Text style={styles.mainGainText}>
            {periodGains[selectedPeriod].mainGain} {periodGains[selectedPeriod].mainLabel}
          </Text>
        </View>

        <View style={financestyles.periodSelector}>
          {(["1D", "1W", "1M"] as const).map((p) => (
            <TouchableOpacity
              key={p}
              onPress={() => setSelectedPeriod(p)}
              style={[
                financestyles.periodButton,
                p === selectedPeriod && financestyles.periodButtonActive,
              ]}
            >
              <Text
                style={[
                  styles.periodText,
                  p === selectedPeriod && financestyles.periodTextActive,
                ]}
              >
                {p}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      {/* Main Chart */}
      <View style={{ paddingBottom: 18 }}>
        <Image source={mainChart} style={financestyles.chartImage} />
      </View>

      {/* Specific Stock Section */}
      <View style={financestyles.paddingHorizontal}>
        <Text style={styles.sectionTitle}>Specific Stock</Text>
        <View style={styles.gainIndicator}>
          <Image source={IMAGES.LAYERS_ICON} style={{ width: 18, height: 18 }} />
          <Text style={styles.subGainText}>
            {periodGains[selectedPeriod].specificGain} {periodGains[selectedPeriod].specificLabel}
          </Text>
        </View>
      </View>

      {/* Specific Stock Chart */}
      <View style={{ paddingBottom: 18 }}>
        <Image source={specificChart} style={financestyles.chartImage} />
      </View>

      {/* Second Period Selector */}
      <View style={{ paddingBottom: 18 }}>
        <View style={financestyles.paddingHorizontal}>
          <View style={financestyles.periodSelector}>
            {(["1D", "1W", "1M"] as const).map((p) => (
              <TouchableOpacity
                key={p}
                onPress={() => setSelectedPeriod2(p)}
                style={[
                  financestyles.periodButton,
                  p === selectedPeriod2 && financestyles.periodButtonActive,
                ]}
              >
                <Text
                  style={[
                    styles.periodText,
                    p === selectedPeriod2 && financestyles.periodTextActive,
                  ]}
                >
                  {p}
                </Text>
              </TouchableOpacity>
            ))}
          </View>
        </View>
      </View>

      {/* Your Position */}
      <View style={financestyles.paddingHorizontal}>
        <View style={{ paddingTop: 16 }}>
          <Text style={styles.sectionTitle}>Your Position</Text>
        </View>

        <View style={styles.positionGrid}>
          <View style={styles.positionItem}>
            <Text style={styles.positionLabel}>{currentData.stocks[0].ticker}</Text>
            <View style={styles.positionRow}>
              <Text style={styles.positionValue}>{currentData.stocks[0].shares} shares</Text>
              <View style={styles.positionDot} />
            </View>
          </View>
          <View style={styles.positionItem}>
            <View style={{ paddingLeft: 16 }}>
              <Text style={styles.positionLabel}>{currentData.stocks[1].ticker}</Text>
              <View style={styles.positionRow}>
                <Text style={styles.positionValue}>{currentData.stocks[1].shares} shares</Text>
                <View style={styles.positionDot} />
              </View>
            </View>
          </View>
          <View style={styles.positionItem}>
            <Text style={styles.positionLabel}>{currentData.stocks[2].ticker}</Text>
            <View style={styles.positionRow}>
              <Text style={styles.positionValue}>{currentData.stocks[2].shares} shares</Text>
              <View style={styles.positionDot} />
            </View>
          </View>
          <View style={styles.positionItem}>
            <View style={{ paddingLeft: 16 }}>
              <Text style={styles.positionLabel}>{currentData.stocks[3].ticker}</Text>
              <View style={styles.positionRow}>
                <Text style={styles.positionValue}>{currentData.stocks[3].shares} shares</Text>
                <View style={styles.positionDot} />
              </View>
            </View>
          </View>
        </View>

        <View style={styles.totalRow}>
          <Text style={styles.totalLabel}>Total Value</Text>
          <View style={styles.totalValueRow}>
            <Text style={styles.totalValue}>{currentData.totalValue}</Text>
            <Text style={styles.totalGain}>{currentData.totalGain}</Text>
          </View>
        </View>
        <View style={styles.divider} />
        <View style={styles.totalRow}>
          <Text style={styles.changeTodayLabel}>{currentData.changeLabel}</Text>
          <View style={styles.totalValueRow}>
            <Text style={styles.totalValue}>{currentData.changeValue}</Text>
            <Text style={styles.totalGain}>{currentData.changeGain}</Text>
          </View>
        </View>
      </View>

      {/* Investment Stats */}
      <View style={{ paddingVertical: 16 }}>
        <View style={financestyles.paddingHorizontal}>
          <Text style={styles.sectionTitle}>Investment Stats</Text>
        </View>
      </View>

      <View style={styles.statsGrid}>
        <View style={styles.statItem}>
          <View style={styles.statRow}>
            <Text style={styles.statLabel}>Total Gain</Text>
            <Text style={styles.statValue}>{currentData.stats.totalGain}</Text>
          </View>
          <View style={styles.bottomLine} />
        </View>

        <View style={styles.statItem}>
          <View style={styles.statRow}>
            <Text style={styles.statLabel}>Total Loss</Text>
            <Text style={styles.statValue}>{currentData.stats.totalLoss}</Text>
          </View>
          <View style={styles.bottomLine} />
        </View>

        <View style={styles.statItem}>
          <View style={styles.statRow}>
            <Text style={styles.statLabel}>Net Gain</Text>
            <Text style={styles.statValue}>{currentData.stats.netGain}</Text>
          </View>
          <View style={styles.bottomLine} />
        </View>

        <View style={styles.statItem}>
          <View style={styles.statRow}>
            <Text style={styles.statLabel}>Best Performer</Text>
            <Text style={styles.statValue}>{currentData.stats.bestPerformer}</Text>
          </View>
          <View style={styles.bottomLine} />
        </View>

        <View style={styles.statItem}>
          <View style={styles.statRow}>
            <Text style={styles.statLabel}>Worst Performer</Text>
            <Text style={styles.statValue}>{currentData.stats.worstPerformer}</Text>
          </View>
          <View style={styles.bottomLine} />
        </View>

        <View style={styles.statItem}>
          <View style={styles.statRow}>
            <Text style={styles.statLabel}>Average Gain</Text>
            <Text style={styles.statValue}>{currentData.stats.averageGain}</Text>
          </View>
          <View style={styles.bottomLine} />
        </View>

        <View style={styles.statItem}>
          <View style={styles.statRow}>
            <Text style={styles.statLabel}>Average Loss</Text>
            <Text style={styles.statValue}>{currentData.stats.averageLoss}</Text>
          </View>
          <View style={styles.bottomLine} />
        </View>

        <View style={styles.statItem}>
          <View style={styles.statRow}>
            <Text style={styles.statLabel}>Total Volume</Text>
            <Text style={styles.statValue}>{currentData.stats.totalVolume}</Text>
          </View>
          <View style={styles.bottomLine} />
        </View>

        <View style={styles.statItem}>
          <View style={styles.statRow}>
            <Text style={styles.statLabel}>Highest Volume</Text>
            <Text style={styles.statValue}>{currentData.stats.highestVolume}</Text>
          </View>
          <View style={styles.bottomLine} />
        </View>

        <View style={styles.statItem}>
          <View style={styles.statRow}>
            <Text style={styles.statLabel}>Lowest Volume</Text>
            <Text style={styles.statValue}>{currentData.stats.lowestVolume}</Text>
          </View>
          <View style={styles.bottomLine} />
        </View>
      </View>

      {/* Volume Section */}
      <View style={financestyles.paddingHorizontal}>
        <View style={styles.volumeRow}>
          <View style={styles.volumeLeft}>
            <Text style={styles.volumeLabel}>{currentData.volumeLabel}</Text>
            <Text style={styles.volumeValue}>{currentData.volumeValue}</Text>
          </View>

          <View style={styles.volumeRight}>
            <TouchableOpacity style={styles.tradeButton}>
              <Text style={styles.tradeButtonText}>Trade Now</Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>

      {/* Need More Help? */}
      <View style={financestyles.paddingHorizontal}>
        <Text style={styles.sectionTitle}>Need More Help?</Text>
        <View style={styles.card}>
          {HELP_ITEMS.map((item, index) => (
            <View key={item.label}>
              <TouchableOpacity style={styles.row} activeOpacity={0.7}>
                <View style={styles.left}>
                  <Image source={item.icon} style={styles.icon} />
                  <Text style={styles.text}>{item.label}</Text>
                </View>

                <Image source={IMAGES.ARROW_RIGHT} style={{ width: 16, height: 16 }} />
              </TouchableOpacity>

              {index !== HELP_ITEMS.length - 1 && <View style={styles.divider} />}
            </View>
          ))}
        </View>
      </View>

      <View style={{ height: 100 }} />
    </ScrollView>
  );
}