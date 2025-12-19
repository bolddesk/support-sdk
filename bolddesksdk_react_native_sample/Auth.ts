import { sign } from "react-native-pure-jwt";
import BoldDeskSupportSDK from "bd-support-sdk-react-native";

async function buildJwt(secretKey: String, email: String): Promise<string> {
    const currentTime = Math.floor(Date.now() / 1000); // seconds since epoch
    const expirationTime = currentTime + 5 * 60; 
    const key = secretKey.toString();
    return sign(
      {
        email: email,
        name: "USER_NAME",
        iat: new Date().getTime(), 
        exp: new Date().getTime() + (5 * 60 * 1000),
      },
      key,
      { alg: 'HS256' }
    );
  }

export async function loginWithJwtIfNeeded(
  secretKey: string,
  email: string
): Promise<void> {
  const isUserLoggedIn = await BoldDeskSupportSDK.isLoggedIn();
  if (isUserLoggedIn) return;

  console.log("User not logged in, so trying login..")

  const jwtToken = await buildJwt(secretKey, email);

  await BoldDeskSupportSDK.loginWithJWTToken(
    jwtToken,
    (msg) => console.log("✅ Login success:", msg),
    (err) => console.log("❌ Login error:", err)
  );
}
