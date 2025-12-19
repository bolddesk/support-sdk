import { StyleSheet, Dimensions } from "react-native"
const { width } = Dimensions.get("window")

export default StyleSheet.create({
    pageContainer: {
        flex: 1,
        backgroundColor: "#fff",
    },

    pageTitle: {
        fontSize: 20,
        fontWeight: "600",
        textAlign: "left",
        color: "#1a1a1a",
    },

    // Gain Indicators
    gainIndicator: {
        flexDirection: "row",
        alignItems: "center",
        gap: 12,
        marginTop: 16,
        marginBottom: 16,
    },
    chartIcon: {
        fontSize: 18,
    },
    mainGainText: {
        fontSize: 16,
        color: "#101828",
        fontWeight: "600",
    },
    subGainText: {
        fontSize: 14,
        color: "#6b7280",
    },

    // Period Selector
    periodSelector: {
        flexDirection: "row",
        backgroundColor: "#f3f4f6",
        borderRadius: 24,
        padding: 4,
        marginBottom: 16,
    },
    periodButton: {
        flex: 1,
        paddingVertical: 8,
        alignItems: "center",
        borderRadius: 20,
    },
    periodButtonActive: {
        backgroundColor: "#fff",
        shadowColor: "#000",
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.1,
        shadowRadius: 2,
        elevation: 2,
    },
    periodText: {
        fontSize: 14,
        color: "#6b7280",
    },
    periodTextActive: {
        color: "#1a1a1a",
        fontWeight: "600",
    },

    // Chart
    chartImageLarge: {
        width: "100%",
        height: 180,
        marginBottom: 24,
    },

    // Sections
    sectionTitle: {
        fontSize: 20,
        fontWeight: "700",
        color: "#111827",
    },

    // Positions
    positionGrid: {
        flexDirection: "row",
        flexWrap: "wrap",
        justifyContent: "space-between",
    },


    positionItem: {
        width: "50%",
        marginBottom: 14,
        marginTop: 14
    },

    positionLabel: {
        fontSize: 14,
        fontWeight: "400",
        color: "#667085",
        marginBottom: 2,
    },

    positionRow: {
        flexDirection: "row",
        alignItems: "center",
        gap: 8, 
        marginTop: 4
    },

    positionValue: {
        fontSize: 18,
        fontWeight: "600",
        color: "#111827",
    },

    positionDot: {
        width: 18,
        height: 18,
        borderRadius: 9,
        borderWidth: 2,
        borderColor: "transparent",
        borderLeftColor: "#6366f1",
        borderTopColor: "#6366f1",
        borderRightColor: "#c7b7ff",
        borderBottomColor: "#c7b7ff",
        transform: [{ rotate: "-45deg" }],
    },

    // Totals
    totalRow: {
        flexDirection: "row",
        alignItems: "center",
        paddingVertical: 14,
    },

    totalLabel: {
        flex: 1,
        fontSize: 14,
        color: "#667085",
        flexDirection: "row",
        justifyContent: "flex-end",
    },

        changeTodayLabel: {
        flex: 1,
        fontSize: 14,
        color: "#101828",
        flexDirection: "row",
        justifyContent: "flex-end",
    },


    totalValueRow: {
        flex: 1,
        flexDirection: "row",
        alignItems: "center",
        gap: 4,
    },

    totalValue: {
        fontSize: 16,
        fontWeight: "600",
        color: "#101828",
    },

    totalGain: {
        fontSize: 14,
        fontWeight: "400",
        color: "#667085",
    },



    // Stats container
    statsGrid: {
        flexDirection: "row",
        flexWrap: "wrap",
        justifyContent: "space-between", // keeps two columns with even gap
    },

    // Each column cell (half width)
    statItem: {
        width: "48%",
        // paddingVertical: 13,
        paddingHorizontal: 16,
    },

    bottomLine: {
        height: 1,                // thickness of the line
        backgroundColor: "#e5e7eb", // light gray color
        marginTop: 14,            // spacing between content and line
        width: "100%",            // full width of the stat item
    },

    // The horizontal row inside each statItem
    statRow: {
        marginTop: 14,
        flexDirection: "row",
        justifyContent: "space-between",
        alignItems: "center",
    },

    // Label styling (left)
    statLabel: {
        fontSize: 14,
        color: "#667085",
        // lighter weight like the screenshot
        fontWeight: "400",
    },

    // Value styling (right — bold and darker)
    statValue: {
        fontSize: 16,
        fontWeight: "700",
        color: "#344054",
    },


    // Stats
    sectionTitleStats: {
        fontSize: 20,
        fontWeight: "700",
        marginBottom: 20,
        color: "#111827",
    },

    // Volume
    // Volume Row
    volumeRow: {
        flexDirection: "row",
        alignItems: "center",
        marginTop: 10,
        paddingTop: 16,
        paddingBottom: 28,
    },

    // Left 50%
    volumeLeft: {
        width: "50%",
        justifyContent: "center",
    },

    // Right 50%
    volumeRight: {
        width: "50%",
        justifyContent: "center",
    },

    volumeLabel: {
        fontSize: 14,
        color: "#667085",
    },

    volumeValue: {
        fontSize: 16,
        fontWeight: "600",
        color: "#101828",
    },

    tradeButton: {
        backgroundColor: "#7c3aed",
        height: 36,
        borderRadius: 8,
        justifyContent: "center",
        alignItems: "center",
    },

    tradeButtonText: {
        color: "#fff",
        fontSize: 16,
        fontWeight: "600",
    },



    // Help Sections
    card: {
        backgroundColor: "#FFFFFF",
        borderRadius: 16,
        paddingVertical: 6,
        shadowColor: "rgba(16, 24, 40, 1)",
        shadowOffset: { width: 0, height: 3 },
        shadowOpacity: 0.1,
        shadowRadius: 4,
        borderWidth: 1,
        borderColor: "#EAECF0",
        marginTop: 16,
    },

    row: {
        flexDirection: "row",
        justifyContent: "space-between",
        alignItems: "center",
        paddingVertical: 10,
        paddingHorizontal: 10,
    },

    left: {
        flexDirection: "row",
        alignItems: "center",
        gap: 12,
    },

    icon: {
        width: 18,
        height: 18,
        resizeMode: "contain",
    },

    icon24: {
        width: 24,
        height: 24,
        resizeMode: "contain",
    },

    topRightMenu: {
        width: 36,
        height: 36,
        justifyContent: "center",
        alignItems: "center",
    },

    text: {
        fontSize: 12,
        color: "#475467",
        fontWeight: "500",
    },
    divider: {
        height: 1,
        backgroundColor: "#EAECF0",
        marginLeft: 0
    },



})
