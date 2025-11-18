/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */
import { View,
  Text,
  TextInput,
  Button,
  ScrollView,
  Platform,
  SafeAreaView,
  StyleSheet, } from 'react-native';
import { BoldDeskSupportSDK, BoldDeskSDKHome } from 'bolddesk_support_sdk';
import { useEffect, useState } from 'react';
import { sign } from 'react-native-pure-jwt';
import { initializeNotifications } from './NotificationsService';

export default function App() {
  const [appId, setAppId] = useState('');
  const [brandUrl, setBrandUrl] = useState('');
  const [secretKey, setSecretKey] = useState('');
  const [email, setEmail] = useState('');
  const [statusMessage, setStatusMessage] = useState('');
  const [loginMessage, setLoginMessage] = useState('');

   useEffect(() => {
    initializeNotifications()
  }, []);

  // --- SDK Initialization ---
  const initializeSDK = () => {
    initializeMethods();
    if (!appId || !brandUrl) {
      setStatusMessage('Please fill both App ID and Brand URL.');
      return;
    }

    BoldDeskSupportSDK.initialize(
      appId,
      brandUrl,
      (msg) => setStatusMessage(`✅ ${msg}`),
      (err) => setStatusMessage(`❌ ${err}`)
    );
  };

  async function buildJwt(secretKey: String, email: String): Promise<string> {
    const currentTime = Math.floor(Date.now() / 1000); // seconds since epoch
    const expirationTime = currentTime + 5 * 60; 
    const key = secretKey.toString();
    return sign(
      {
        email: email,
        name: "boomi balan",
        iat: new Date().getTime(), 
        exp: new Date().getTime() + (5 * 60 * 1000),
      },
      key,
      { alg: 'HS256' }
    );
  }

  // --- Login using Secret Key & Email ---
  const loginUser = async () => {
    if (await BoldDeskSupportSDK.isLoggedIn()) {
      setLoginMessage('User already logged in');
      return;
    }
    if (!secretKey || !email) {
      setLoginMessage('Please enter Secret Key and Email ID.');
      return;
    }

    const jwtToken = await buildJwt(secretKey, email);

    BoldDeskSupportSDK.loginWithJWTToken(
      jwtToken,
      (msg) => setLoginMessage(`✅ ${msg}`),
      (err) => setLoginMessage(`❌ ${err}`)
    );
  };

  // --- Set SDK Configuration (Theme, Fonts, Logging, etc.) ---
  const initializeMethods = () => {
    // We can logging debug logging enable/disable
    BoldDeskSupportSDK.setLoggingEnabled(true);
    // Customize theme, accent color and primary color
    BoldDeskSupportSDK.applyTheme('#FF0000', '#00FF00');
    // Set preferred theme - light/dark/system
    BoldDeskSupportSDK.setPreferredTheme?.('system');
    // Set system font size enable/disable
    BoldDeskSupportSDK.setSystemFontSize?.(false);
    // Customize font family in Android
    // Need to add font files in android/app/src/main/res/font/
    if (Platform.OS === 'android') {
      // BoldDeskSupportSDK.applyCustomFontFamilyInAndroid(
      //   'dancingscript_bold',
      //   'dancingscript_semibold',
      //   'dancingscript_medium',
      //   'dancingscript_regular'
      // );
    } else {
      // Customize font family in iOS
      BoldDeskSupportSDK.applyCustomFontFamilyIniOS('Times New Roman');
    }
    // Set custom logo in home screen
    BoldDeskSDKHome.setHeaderLogo?.(
      'https://images.google.com/images/branding/googlelogo/2x/googlelogo_light_color_272x92dp.png'
    );
    // Set custom content in home screen
    BoldDeskSDKHome.setHomeDashboardContent({
          headerName: "Welcome to BoldDesk",
          headerDescription: "Manage your tickets and knowledge base efficiently",
          kbTitle: "test Base",
          kbDescription: "Search articles and FAQs",
          ticketTitle: "Submit a Ticket",
          ticketDescription: "Report your issue or request support",
          submitButtonText: "Submit Now"
        });
  };

  return (
     <SafeAreaView style={{ flex: 1, backgroundColor: '#fff' }}>
    <ScrollView contentContainerStyle={styles.container}>
      <Text style={styles.header}>BoldDesk Support SDK Example</Text>

      <TextInput
        style={styles.input}
        placeholder="App ID"
        value={appId}
        onChangeText={setAppId}
      />
      <TextInput
        style={styles.input}
        placeholder="Brand URL"
        value={brandUrl}
        onChangeText={setBrandUrl}
      />

      {statusMessage ? (
        <Text style={styles.status}>{statusMessage}</Text>
      ) : null}

      <Button title="Initialize SDK" onPress={initializeSDK} />

      <TextInput
        style={styles.input}
        placeholder="Secret Key"
        value={secretKey}
        onChangeText={setSecretKey}
      />
      <TextInput
        style={styles.input}
        placeholder="Email ID"
        value={email}
        onChangeText={setEmail}
      />

      {loginMessage ? <Text style={styles.status}>{loginMessage}</Text> : null}

      <View style={styles.row}>
        <Button title="Login" onPress={loginUser} />
        <View style={{ width: 20 }} />
        <Button title="Logout" onPress={() => BoldDeskSupportSDK.logout()} />
      </View>

      <View style={styles.spacer} />

      <Button title="Show Home Screen" onPress={() => BoldDeskSupportSDK.showHome()} />
      <View style={styles.spacer} />
      <Button
        title="Show Create Ticket"
        onPress={() => BoldDeskSupportSDK.showSubmitTicket()}
      />
      <View style={styles.spacer} />
      <Button title="Show KB" onPress={() => BoldDeskSupportSDK.showKB()} />
    </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    padding: 20,
  },
  header: {
    fontSize: 20,
    fontWeight: '600',
    marginBottom: 10,
  },
  input: {
    borderWidth: 1,
    borderColor: '#aaa',
    borderRadius: 5,
    padding: 10,
    marginVertical: 5,
  },
  row: {
    flexDirection: 'row',
    marginTop: 10,
    justifyContent: 'center',
  },
  spacer: {
    height: 10,
  },
  status: {
    fontSize: 16,
    color: '#333',
    marginVertical: 5,
  },
});

