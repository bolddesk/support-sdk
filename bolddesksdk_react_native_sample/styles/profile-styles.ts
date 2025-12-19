import { StyleSheet } from "react-native";

export default StyleSheet.create({

    topRightMenu: {
        position: "absolute",
        top: 16,
        left: 16,
        width: 32,
        height: 32,
        justifyContent: "center",
        alignItems: "center",
        zIndex: 10,
    },

    // Avatar outside overlay, floating at bottom-right of the banner
    avatarWrapperOutside: {
        position: "absolute",
        bottom: 14,       // adjust so it hangs outside the banner
        right: 16,
        width: 90,
        height: 90,
        padding: 5,
        borderRadius: 45,
        justifyContent: "center",
        alignItems: "center",
        zIndex: 5,
    },

    profileAvatar: {
        width: "100%",
        height: "100%",
        borderRadius: 45,
    },

    qrBadge: {
        position: "absolute",
        bottom: -2,
        right: -2,
        width: 34,
        height: 34,
        borderRadius: 25,
        backgroundColor: "#fff",
        borderColor: "#EAECF0",
        borderWidth: 1,
        justifyContent: "center",
        alignItems: "center",
        elevation: 4,
        shadowColor: "#1018280F",
        shadowOpacity: 0.15,
        shadowRadius: 6,
        shadowOffset: { width: 0, height: 2 },
    },

    qrIcon: {
        width: 18,
        height: 18,
    },

    stackContainer: {
        position: "relative",
    },

    banner: {
        width: "100%",
        height: 248,
        resizeMode: "cover",
    },

    bannerContainer: {
        position: "relative",
    },

    fadeOverlay: {
        position: "absolute",
        bottom: -12,
        width: "100%",
        height: 35,        // adjust strength of fade
        resizeMode: "stretch",
    },


    profileOverlay: {
        position: "absolute",
        left: 20,
        right: 20,
        paddingTop: 24,
        paddingBottom: 40,
        bottom: 0,
        flexDirection: "row",
        alignItems: "center",
    },

    profileName: {
        fontSize: 24,
        marginBottom: 12,
        fontWeight: "600",
        color: "#101828",
    },

    upiId: {
        marginTop: 12,
        fontSize: 16,
        fontWeight: "500",
        color: "#344054",
    },

    phoneRow: {
        flexDirection: "row",
        alignItems: "center",
        marginTop: 12,
        gap: 8,
    },

    phoneNumber: {
        fontSize: 16,
        fontWeight: "500",
        color: "#344054",
    },

    upiChip: {
        flexDirection: "row",
        alignItems: "center",
        backgroundColor: "#F9F5FF",
        borderColor: "#E9D7FE",
        borderWidth: 1,
        borderRadius: 50,
        paddingHorizontal: 8,
        paddingVertical: 4,
        gap: 6
    },

    chipIcon: {
        width: 16,
        height: 16,
    },

    upiChipText: {
        fontSize: 14,
        fontWeight: "500",
        color: "#6941C6",
    },

    profileAvatarSmall: {
        width: 68,
        height: 68,
        borderRadius: 34,
        marginLeft: 16,
    },

    container: {
        flex: 1,
        backgroundColor: "#fff",
    },

    //Profile avatar
    avatarWrapper: {
        width: 90,
        height: 90,
        borderRadius: 50,
        position: "relative",   // IMPORTANT for layering
        justifyContent: "center",
        alignItems: "center",
    },

    rewardRow: {
        flexDirection: "row",
        justifyContent: "space-between",
        paddingHorizontal: 20,
        marginTop: 20,
    },

    rewardBox: {
        flexDirection: "row",
        backgroundColor: "#fde4ef",
        paddingVertical: 8,
        paddingHorizontal: 16,
        borderRadius: 50,
        height: 54,
        width: "48%",
        alignItems: "center",
        gap: 12,
    },

    referBox: {
        flexDirection: "row",
        backgroundColor: "#e0f2fe",
        padding: 16,
        borderRadius: 50,
        height: 54,
        width: "48%",
        alignItems: "center",
        gap: 12,
    },

    rewardIcon: { width: 18, height: 18 },

    rewardTitle: {
        fontSize: 14,
        fontWeight: "600",
        color: "#C11574",
    },

    rewardSubtitle: {
        color: "#C11574",
        fontSize: 12,
        fontWeight: "500",
    },

    referTitle: {
        fontSize: 14,
        fontWeight: "600",
        color: "#026AA2",
    },

    referSubtitle: {
        color: "#026AA2",
        fontSize: 12,
        fontWeight: "500",
    },

    paymentContainer: {
        backgroundColor: "#F9FAFB",
        borderColor: "#EAECF0",
        borderWidth: 1,
        borderRadius: 18,
        paddingHorizontal: 12,
        paddingVertical: 16,
        marginVertical: 12,
        marginHorizontal: 16
    },

    paymentHeaderRow: {
        flexDirection: "row",
        justifyContent: "space-between",
        alignItems: "center",
    },

    paymentTitle: {
        fontSize: 16,
        fontWeight: "600",
        color: "#101828",
    },

    arrowIcon: { width: 20, height: 20 },

    paymentCardsRow: {
        flexDirection: "row",
        justifyContent: "space-between",
        marginTop: 16,
    },

    paymentCard: {
        width: "30%",
        alignItems: "center",
    },

    paymentIconWrapper: {
        width: 60,
        height: 50,
        borderRadius: 30,
        backgroundColor: "#f1f5f9",
        justifyContent: "center",
        alignItems: "center",
        marginBottom: 20,
    },

    bankAccounIconWrapper: {
        width: 60,
        height: 50,
        borderRadius: 30,
        justifyContent: "center",
        alignItems: "center",
        marginBottom: 20,
    },

    paymentIcon: {
        width: 60,
        height: 60,
    },

    bankAccountIcon: {
        width: 34,
        height: 34,
    },

    paymentLabel: {
        fontSize: 14,
        fontWeight: "600",
        color: "#101828",
        textAlign: "center",
    },

    paymentSubLabel: {
        fontSize: 12,
        color: "#344054",
        textAlign: "center",
        fontWeight: "500",
        marginTop: 2,
    },

    listWrapper: {
        marginTop: 0,
    },

    listItem: {
        flexDirection: "row",
        justifyContent: "space-between",
        alignItems: "center",
        paddingVertical: 17,
        paddingHorizontal: 16,
    },

    listItemLeft: {
        flexDirection: "row",
        alignItems: "center",
        gap: 12,
    },

    listItemText: {
        fontSize: 16,
        color: "#344054",
        fontWeight: "500"
    },

    icon24: { width: 24, height: 24 },
    icon22: { width: 22, height: 22 },

    rightArrow: { width: 14, height: 14, opacity: 0.4 },

    redDot: {
        width: 8,
        height: 8,
        borderRadius: 4,
        backgroundColor: "#D92D20",
    },

});
