"use client";
import { View, Text, Image, ScrollView, TouchableOpacity } from "react-native";
import { IMAGES } from "../constants/constants";
import styles from "../styles/profile-styles";
import { useNavigation } from "@react-navigation/native";
import BoldDeskSupportSDK from "bd-support-sdk-react-native";

export default function ProfileScreen() {
  const navigation = useNavigation();

  return (<ScrollView style={styles.container} bounces={false} showsVerticalScrollIndicator= {false} >

    {/* STACK CONTAINER */}
    <View style={styles.stackContainer}>

      {/* Banner with fade */}
      <View style={styles.bannerContainer}>
        <Image source={IMAGES.PROFILE_BANNER} style={styles.banner} />
        <Image source={IMAGES.BANNER_FADE} style={styles.fadeOverlay} />
      </View>

      {/* Top-right three-dot menu */}
      <TouchableOpacity style={styles.topRightMenu} onPress={() => navigation.goBack()}>
        <Image source={IMAGES.ARROW_RIGHT} style={[styles.icon24, { transform: [{ scaleX: -1 }] }]} />
      </TouchableOpacity>

      {/* Profile Info (inside overlay) */}
      <View style={styles.profileOverlay}>
        <View style={{ flex: 1 }}>
          <Text style={styles.profileName}>Olivia Rhye</Text>
          <Text style={styles.upiId}>UPI ID: Olivi.ye01-2@okhdfcbank</Text>

          <View style={styles.phoneRow}>
            <Text style={styles.phoneNumber}>9191323909</Text>

            <TouchableOpacity style={styles.upiChip}>
              <Image source={IMAGES.VERIFIED} style={styles.chipIcon} />
              <Text style={styles.upiChipText}>UPI Number</Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>

      {/* Avatar (outside the overlay, bottom-right) */}
      <View style={styles.avatarWrapperOutside}>
        <Image source={IMAGES.PROFILE_IMAGE} style={styles.profileAvatar} />
        <View style={styles.qrBadge}>
          <Image source={IMAGES.QR_CODE} style={styles.qrIcon} />
        </View>
      </View>

    </View>


    {/* Rewards + Refer */}
    <View style={styles.rewardRow}>
      <TouchableOpacity style={styles.rewardBox}>
        <Image source={IMAGES.REWARD} style={styles.rewardIcon} />
        <View>
          <Text style={styles.rewardTitle}>7 Rewards</Text>
          <Text style={styles.rewardSubtitle}>View Now</Text>
        </View>
      </TouchableOpacity>

      <TouchableOpacity style={styles.referBox}>
        <Image source={IMAGES.REFER} style={styles.rewardIcon} />
        <View>
          <Text style={styles.referTitle}>Get ₹20</Text>
          <Text style={styles.referSubtitle}>Refer a friend</Text>
        </View>
      </TouchableOpacity>
    </View>


    {/* Payment Methods */}
    <View style={styles.paymentContainer}>
      <View style={styles.paymentHeaderRow}>
        <Text style={styles.paymentTitle}>Set up payment methods 1/3</Text>
        <Image source={IMAGES.CHEVRON_RIGHT} style={styles.arrowIcon} />
      </View>

      <View style={styles.paymentCardsRow}>
        {/* Bank */}
        <View style={styles.paymentCard}>
          <View style={styles.bankAccounIconWrapper}>
            <Image source={IMAGES.BANK_ACCOUNT} style={styles.bankAccountIcon} />
          </View>
          <Text style={styles.paymentLabel}>Bank Account</Text>
          <Text style={styles.paymentSubLabel}>2 accounts</Text>
        </View>

        {/* Credit card */}
        <View style={styles.paymentCard}>
          <View style={styles.paymentIconWrapper}>
            <Image source={IMAGES.CREDIT_CARD} style={styles.paymentIcon} />
          </View>
          <Text style={styles.paymentLabel}>Credit Card</Text>
          <Text style={styles.paymentSubLabel}>Pay with UPI</Text>
        </View>

        {/* UPI Lite */}
        <View style={styles.paymentCard}>
          <View style={styles.paymentIconWrapper}>
            <Image source={IMAGES.UPI_LITE} style={styles.paymentIcon} />
          </View>
          <Text style={styles.paymentLabel}>UPI Lite</Text>
          <Text style={styles.paymentSubLabel}>Pay PIN-Free</Text>
        </View>
      </View>
    </View>

    {/* Main List */}
    <View style={styles.listWrapper}>
      <Item icon={<Image source={IMAGES.HELP} style={styles.icon22} />} label="Get Help" isShowRed={true} />
      <Item icon={<Image source={IMAGES.CHAT} style={styles.icon22} />} label="Contact us" isShowRed={true} />
      <Item icon={<Image source={IMAGES.WALLET} style={styles.icon22} />} label="Pay with credit or debit cards" />
      <Item icon={<Image source={IMAGES.QR_CODE} style={styles.icon22} />} label="Your QR code" />
      <Item icon={<Image source={IMAGES.HISTORY} style={styles.icon22} />} label="Transaction History" />
      <Item icon={<Image source={IMAGES.SETTING} style={styles.icon22} />} label="Settings" />
    </View>

    <View style={{ height: 50 }} />
  </ScrollView>

  );
}

function Item({
  icon,
  label,
  isShowRed = false,
}: {
  icon: React.ReactNode;
  label: string;
  isShowRed?: boolean;
}) {

  const handlePress = () => {
    if (label === 'Get Help') {
      BoldDeskSupportSDK.showHome();
    }
  };

  return (
    <TouchableOpacity
      style={styles.listItem}
      onPress={handlePress}
      activeOpacity={0.7}
    >
     <View style={styles.listItemLeft}>
        {icon}
        <Text style={styles.listItemText}>{label}</Text>
      </View>

      {/* Right Side */}
      {isShowRed && <View style={styles.redDot} />}
    </TouchableOpacity>
  );
}

