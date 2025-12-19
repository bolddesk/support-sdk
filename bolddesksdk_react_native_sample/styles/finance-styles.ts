import { StyleSheet, Dimensions } from "react-native";
const { width } = Dimensions.get("window");

export default StyleSheet.create({
    pageContainer: {
        flex: 1,
        paddingVertical: 16,
        backgroundColor: "#ffffff",
    },

    pageTitle: {
        fontSize: 20,
        fontWeight: "600",
        textAlign: "center",
        marginBottom: 24,
        color: "#111827",
    },

    balanceCard: {
        backgroundColor: "#ffffff",
        borderRadius: 12,
        padding: 16,
        marginBottom: 16,
        shadowColor: "rgba(16, 24, 40, 1)",
        shadowOffset: { width: 0, height: 3 },
        shadowOpacity: 0.1,
        shadowRadius: 4,
    },

    balanceHeader: {
        flexDirection: "row",
        justifyContent: "space-between",
        alignItems: "center",
    },

    balanceLabel: {
        fontSize: 16,
        fontWeight: "600",
        color: "#101828",
    },

    showText: {
        fontSize: 14,
        fontWeight: "600",
        color: "#6941C6",
    },

    balanceAmount: {
        fontSize: 30,
        fontWeight: "600",
        color: "#344054",
        marginVertical: 16,
    },

    buttonRow: {
        flexDirection: "row",
        justifyContent: "space-between",
    },

    addMoneyButton: {
        flex: 1,
        backgroundColor: "#7C3AED",
        borderRadius: 6,
        alignItems: "center",
        height: 32,
        marginRight: 8,
    },

    addMoneyText: {
        color: "#ffffff",
        fontSize: 14,
        marginVertical: 6,
        fontWeight: "600",
    },

    withdrawButton: {
        flex: 1,
        backgroundColor: "#ffffff",
        borderRadius: 6,
        alignItems: "center",
        height: 32,
        borderWidth: 1,
        borderColor: "#E5E7EB",
    },

    withdrawText: {
        color: "#7C3AED",
        fontSize: 14,
        marginVertical: 6,
        fontWeight: "600",
    },

    /* FEATURES */
    featureGrid: {
        flexDirection: "row",
        flexWrap: "wrap",
        marginBottom: 16,
        marginTop: 8,
        justifyContent: "space-between",
    },

    featureCard: {
        width: (width - 48) / 2,
        padding: 16,
        backgroundColor: "#ffffff",
        borderRadius: 12,
        marginBottom: 16,
        shadowColor: "rgba(16, 24, 40, 1)",
        shadowOffset: { width: 0, height: 3 },
        shadowOpacity: 0.1,
        shadowRadius: 4,
        elevation: 2,
    },

    featureIcon: {
        width: 32,
        height: 32,
        marginBottom: 48,
    },

    featureTitle: {
        fontSize: 16,
        fontWeight: "600",
        color: "#101828",
    },

    featureSubtitle: {
        fontSize: 14,
        fontWeight: "400",
        color: "#344054",
        marginTop: 4,
    },

    todaysGainsTitle: {
        fontSize: 20,
        fontWeight: "600",
        marginBottom: 16,
        color: "#101828",
    },

    gainRow: {
        flexDirection: "row",
        alignItems: "center",
        marginBottom: 16,
    },

    paddingHorizontal: {
        paddingHorizontal: 16,
    },

    gainArrow: {
        fontSize: 18,
        color: "#16A34A", // green
        marginRight: 4,
    },

    gainPercent: {
        fontSize: 18,
        fontWeight: "600",
        color: "#079455",
        marginRight: 4,
    },

    gainLabel: {
        fontSize: 18,
        fontWeight: "600",
        color: "#344054",
    },


    /* PERIOD SELECTOR */
    periodSelector: {
        flexDirection: "row",
        backgroundColor: "#F2F4F7",
        borderRadius: 24,
        padding: 2,
        height: 36,
        marginTop: 16,
        alignItems: "center",
    },

    periodButton: {
        flex: 1,
        borderRadius: 20,
        height: 32,
        alignItems: "center",
        justifyContent: "center",
    },


    periodButtonActive: {
        backgroundColor: "#ffffff",
    },

    periodText: {
        color: "#667085",
        fontSize: 14,
        fontWeight: "600",
        textAlign: "center",
    },
    periodTextActive: {
        color: "#111827",
        fontSize: 14,
        fontWeight: "600",
        textAlign: "center",
    },


    chartImage: {
        width: "100%",
        height: 200,
        // resizeMode: "contain",
    },

    //Section
    stocksHeaderRow: {
        flexDirection: "row",
        justifyContent: "space-between",
        alignItems: "center",
        width: "100%",
        paddingRight: 4,
        marginTop: 4,
        marginBottom: 16,
    },

    stocksLeft: {
        flexShrink: 1,
    },

    sectionTitle: {
        fontSize: 20,
        fontWeight: "600",
        color: "#101828",
    },

    stocksSubtitle: {
        fontSize: 14,
        color: "#475467",
        fontWeight: "400",
        marginTop: 2,
    },

    arrowRight: {
        width: 24,
        height: 24,
        resizeMode: "contain",
        marginLeft: 12,
    },

    stockGrid: {
        flexDirection: "row",
        flexWrap: "wrap",
        justifyContent: "space-between",
    },

    stockCard: {
        width: (width - 44) / 2,
        backgroundColor: "#F9F5FF",
        borderRadius: 12,
        padding: 16,
        marginBottom: 12,
    },

    stockName: {
        fontSize: 16,
        fontWeight: "600",
        color: "#101828",
    },

    stockPrice: {
        fontSize: 14,
        marginTop: 4,
        fontWeight: "400",
        color: "#475467",
    },

    miniChart: {
        width: "100%",
        height: 56,
        marginVertical: 8,
        resizeMode: "contain",
    },

    stockGainPositive: {
        color: "#6941C6",
        fontSize: 13,
        fontWeight: "500",
    },

    stockGainNegative: {
        color: "#6941C6",
        fontSize: 13,
        fontWeight: "500",
    },
});
