import { StyleSheet } from "react-native";

export default StyleSheet.create({
  navContainer: {
    position: "absolute",
    bottom: 16,
    left: 16,
    right: 16,
    flexDirection: "row",
    justifyContent: "space-around",
    alignItems: "center",
    backgroundColor: "#F9FAFB",
    color: "#F9FAFB",
    borderRadius: 40,
    paddingVertical: 12,
    paddingHorizontal: 10,

    shadowColor: "#000",
    shadowOpacity: 0.1,
    shadowRadius: 12,
    elevation: 4,
  },

  item: {
    alignItems: "center",
    width: "25%",
  },

  iconWrapper: {
    position: "relative",
    justifyContent: "center",
    alignItems: "center",
  },

  icon: {
    width: 24,
    height: 24,
    tintColor: "#667085",
  },

  label: {
    marginTop: 6,
    fontSize: 12,
    fontWeight: "500",
    color: "##344054",
  },

  redDot: {
    position: "absolute",
    top: 0,
    right: 0,
    width: 10,
    height: 10,
    borderRadius: 5,
    backgroundColor: "#D92D20",
  },
});
