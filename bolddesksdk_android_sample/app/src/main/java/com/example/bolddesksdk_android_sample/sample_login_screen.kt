package com.example.bolddesksdk_android_sample

import android.annotation.SuppressLint
import android.content.res.Configuration
import android.util.Log
import android.widget.Toast
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Done
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.rememberModalBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.syncfusion.bolddeskmobileSDK.BoldDeskSupportSDK
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

// Define predefined colors for the color picker (expandable list)
val colorOptions = listOf(
    "#0C33F3",
    "#2A9201",
    "#FFFF00",
    "#00FFFF",
    "#FFA500",
    "#7F56D9",
)

@SuppressLint("CoroutineCreationDuringComposition", "LocalContextConfigurationRead")
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun LoginScreen(
    modifier: Modifier = Modifier,
    padding: PaddingValues = PaddingValues(0.dp)
) {
    val coroutineScope = rememberCoroutineScope()
    val context = LocalContext.current
    val focusManager = LocalFocusManager.current
    val configuration: Configuration = context.resources.configuration
    val isTablet = configuration.smallestScreenWidthDp >= 600
    // State for text fields (internal, but can be externalized)
    var appId by remember { mutableStateOf("") }
    var brandUrl by remember { mutableStateOf("") }
    var serverKey by remember { mutableStateOf("") }
    var clientEmail by remember { mutableStateOf("") }
    var selectedButtonColor by remember { mutableStateOf("") }
    var selectedAppBarColor by remember { mutableStateOf("") }
    var selectedFontFamily by remember { mutableStateOf("Inter") }
    var selectedAppTheme by remember { mutableStateOf("System Default") }
    var isLoading by remember { mutableStateOf(false) }


    fun checkLoginEnabled(): Boolean {
        return appId.isNotBlank() &&
                brandUrl.isNotBlank()
    }


    fun applyConfigurations() {
        try {
            if (selectedAppBarColor.isNotBlank() && selectedButtonColor.isNotBlank()) {
                BoldDeskSupportSDK.applyTheme(
                    selectedAppBarColor,
                    accentColor = selectedButtonColor
                )
            }
            when (selectedFontFamily) {
                "DancingScript" -> BoldDeskSupportSDK.applyCustomFontFamily(
                    regular = R.font.dancingscript_regular,
                    bold = R.font.dancingscript_bold,
                    semiBold = R.font.dancingscript_semibold,
                    medium = R.font.dancingscript_medium,
                )

                "Inter" -> BoldDeskSupportSDK.applyCustomFontFamily(
                    regular = R.font.inter_regular,
                    bold = R.font.inter_bold,
                    semiBold = R.font.inter_semibold,
                    medium = R.font.inter_medium,
                )

                "Roboto" -> BoldDeskSupportSDK.applyCustomFontFamily(
                    regular = R.font.roboto_regular,
                    bold = R.font.roboto_bold,
                    semiBold = R.font.roboto_semibold,
                    medium = R.font.roboto_medium,
                )

                "QuickSand" -> BoldDeskSupportSDK.applyCustomFontFamily(
                    regular = R.font.quicksand_regular,
                    bold = R.font.quicksand_bold,
                    semiBold = R.font.quicksand_semibold,
                    medium = R.font.quicksand_medium,
                )
            }
            when (selectedAppTheme) {
                "System Default" -> BoldDeskSupportSDK.setPreferredTheme("system default")
                "Dark" -> BoldDeskSupportSDK.setPreferredTheme("dark")
                "Light" -> BoldDeskSupportSDK.setPreferredTheme("light")
            }
        } catch (e: Exception) {
            Log.d("BoldDeskSample", e.toString())
        }
    }
    Box(modifier = Modifier.fillMaxSize()) {
        Scaffold(
            modifier = Modifier.fillMaxSize(),
            topBar = { CommonAppBar() }
        ) { innerPadding ->

            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(innerPadding)
                    .padding(horizontal = 16.dp, vertical = 10.dp)
                    .verticalScroll(rememberScrollState()),
                verticalArrangement = Arrangement.spacedBy(16.dp),
            ) {
                Text("Initialize: ", style = MaterialTheme.typography.labelLarge)
                // Four Text Fields
                InputField(
                    textValue = appId,
                    label = "App ID",
                    isMandatory = false,
                    onValueChange = {
                        appId = it
                    }
                )
                InputField(
                    textValue = brandUrl,
                    label = "Brand URL",
                    isMandatory = false,
                    onValueChange = {
                        brandUrl = it
                    }
                )
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.End) {
                    ButtonWidget(
                        text = "Initialize",
                        onClick = {
                            if (checkLoginEnabled()) {
                                coroutineScope.launch {
                                    isLoading = true
                                    applyConfigurations()
                                    withContext(Dispatchers.IO) {
                                        BoldDeskSupportSDK.initialize(
                                            context = context, appId, brandUrl,
                                            onSuccessCallback = {
                                                coroutineScope.launch(Dispatchers.Main) {
                                                    isLoading = false
                                                    Toast.makeText(
                                                        context,
                                                        it,
                                                        Toast.LENGTH_SHORT
                                                    ).show()
                                                }

                                            },
                                            onErrorCallback = {
                                                coroutineScope.launch(Dispatchers.Main) {
                                                    isLoading = false
                                                    Toast.makeText(
                                                        context,
                                                        it,
                                                        Toast.LENGTH_SHORT
                                                    ).show()
                                                }

                                            })
                                    }
                                }
                            } else {
                                Toast.makeText(
                                    context,
                                    "Please fill Above Fields",
                                    Toast.LENGTH_SHORT
                                ).show()
                            }
                        }
                    )
                    ButtonWidget(
                        text = "Clear All Data",
                        onClick = {
                            BoldDeskSupportSDK.clearAllLocalData(context)
                        }
                    )
                }
                Text("Login: ", style = MaterialTheme.typography.labelLarge)
                InputField(
                    textValue = serverKey,
                    label = "Server Key",
                    isMandatory = false,
                    onValueChange = {
                        serverKey = it
                    }
                )
                InputField(
                    textValue = clientEmail,
                    label = "Client Email",
                    isMandatory = false,
                    onValueChange = {
                        clientEmail = it
                    }
                )
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.End) {
                    ButtonWidget(
                        text = "Login",
                        onClick = {
                            if (BoldDeskSupportSDK.isLoggedIn(context)) {
                                Toast.makeText(
                                    context,
                                    "User Already Logged In",
                                    Toast.LENGTH_SHORT
                                ).show()
                            } else {
                            if (clientEmail.isNotEmpty() && serverKey.isNotEmpty()) {
                                coroutineScope.launch {
                                    isLoading = true
                                    getToken()
                                    delay(100)
                                    BoldDeskSupportSDK.setFCMRegistrationToken(context, fcm_token)
                                    val jwt = JWTUtils.generateJwt(
                                        clientEmail,
                                        serverKey
                                    )
                                    withContext(Dispatchers.IO) {
                                        BoldDeskSupportSDK.loginWithJWTToken(
                                            context,
                                            jwtToken = jwt,
                                            onSuccessCallback = {
                                                coroutineScope.launch(Dispatchers.Main) {
                                                    isLoading = false
                                                    Toast.makeText(
                                                        context,
                                                        it,
                                                        Toast.LENGTH_SHORT
                                                    ).show()
                                                }
                                            },
                                            onErrorCallback = {
                                                coroutineScope.launch(Dispatchers.Main) {
                                                    isLoading = false
                                                    Toast.makeText(
                                                        context,
                                                        it,
                                                        Toast.LENGTH_SHORT
                                                    ).show()
                                                }
                                            }
                                        )
                                    }
                                }
                            } else {
                                Toast.makeText(
                                    context,
                                    "Please fill Above Fields",
                                    Toast.LENGTH_SHORT
                                ).show()
                            }
                        }
                        }
                    )
                    ButtonWidget(
                        text = "Logout",
                        onClick = {
                            BoldDeskSupportSDK.logout(context)
                        }
                    )
                }
                // Color Picker: Row of color circles
                Text("AppBar Theme:", style = MaterialTheme.typography.labelLarge)
                Row(
                    horizontalArrangement = Arrangement.spacedBy(8.dp),
                    modifier = Modifier.padding(top = 8.dp)
                ) {
                    colorOptions.forEach { color ->
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            Box(
                                modifier = Modifier
                                    .size(40.dp)
                                    .border(
                                        3.dp,
                                        if (selectedAppBarColor == color) Color.Black else Color.Transparent,
                                        shape = CircleShape
                                    )
                                    .background(hexToColor(color) ?: Color.Green, CircleShape)
                                    .clickable {
                                        focusManager.clearFocus()
                                        selectedAppBarColor = if (selectedAppBarColor == color) {
                                            ""
                                        } else {
                                            color
                                        }
                                    }
                            )
                        }
                    }
                }
                // Color Picker: Row of color circles
                Text("Button Theme:", style = MaterialTheme.typography.labelLarge)
                Row(
                    horizontalArrangement = Arrangement.spacedBy(8.dp),
                    modifier = Modifier.padding(top = 8.dp)
                ) {
                    colorOptions.forEach { color ->
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            Box(
                                modifier = Modifier
                                    .size(40.dp)
                                    .border(
                                        3.dp,
                                        if (selectedButtonColor == color) Color.Black else Color.Transparent,
                                        shape = CircleShape
                                    )
                                    .background(hexToColor(color) ?: Color.Green, CircleShape)
                                    .clickable {
                                        focusManager.clearFocus()
                                        selectedButtonColor = if (selectedButtonColor == color) {
                                            ""
                                        } else {
                                            color
                                        }
                                    }
                            )
                        }
                    }
                }
                Text("Font Family:", style = MaterialTheme.typography.labelLarge)
                SheetWidget(
                    options = listOf("DancingScript", "Inter", "Roboto", "QuickSand"),
                    selectedOption = selectedFontFamily,
                    onSelectionChange = {
                        focusManager.clearFocus()
                        selectedFontFamily = it
                    }
                )
                Text("App Theme:", style = MaterialTheme.typography.labelLarge)
                SheetWidget(
                    options = listOf("System Default", "Dark", "Light"),
                    selectedOption = selectedAppTheme,
                    onSelectionChange = {
                        focusManager.clearFocus()
                        selectedAppTheme = it
                    }
                )
                Row {
                    ButtonWidget(
                        text = "Open Home Screen",
                        onClick = {
                            focusManager.clearFocus()
                            applyConfigurations()
                            BoldDeskSupportSDK.showHomeDashboard(context = context)
                        }
                    )
                    ButtonWidget(
                        text = "Open Create Ticket",
                        onClick = {
                            focusManager.clearFocus()
                            applyConfigurations()
                            BoldDeskSupportSDK.showCreateTicket(context = context)
                        }
                    )
                    if (isTablet)
                        ButtonWidget(
                            text = "Open KB",
                            onClick = {
                                focusManager.clearFocus()
                                applyConfigurations()
                                BoldDeskSupportSDK.showKB(context = context)
                            }
                        )
                }
                if (!isTablet)
                    Row {
                        ButtonWidget(
                            text = "Open KB",
                            onClick = {
                                focusManager.clearFocus()
                                applyConfigurations()
                                BoldDeskSupportSDK.showKB(context = context)
                            }
                        )
                    }
            }
            if (isLoading) {
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(Color.Gray.copy(alpha = 0.7f)) // Semi-transparent background
                        .pointerInput(Unit) { detectTapGestures(onTap = {}) } // Consume all touch events
                        .clickable(
                            enabled = false,
                            onClick = {}), // Ensure it's not clickable itself
                    contentAlignment = Alignment.Center
                ) {
                    CircularProgressIndicator(
                        modifier = Modifier.size(40.dp),
                        color = Color.Blue, // Or MaterialTheme.colorScheme.primary
                        strokeWidth = 5.dp
                    )
                }
            }
        }
    }
}


@Composable
fun InputField(
    textValue: String,
    label: String,
    isMandatory: Boolean,
    onValueChange: (String) -> Unit = {}
) {
    OutlinedTextField(
        value = textValue,
        onValueChange = onValueChange,
        label = {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(
                    text = label
                )
                Spacer(modifier = Modifier.width(4.dp))
                if (isMandatory)
                    Text(text = "*", color = Color.Red)
            }
        },
        modifier = Modifier.fillMaxWidth()
    )
}

@Composable
fun ButtonWidget(text: String, onClick: () -> Unit, modifier: Modifier = Modifier) {
    Button(
        onClick = onClick,
        modifier = modifier
            .height(50.dp)
            .padding(5.dp),
        enabled = true,
        shape = RoundedCornerShape(6.dp),
        content = {
            Text(
                text,
                style = MaterialTheme.typography.labelLarge.copy(
                    fontWeight = FontWeight.W600,
                    color = Color.White,
                ),
                maxLines = 1
            )
        },
        contentPadding = PaddingValues(
            start = 16.dp,
            end = 16.dp
        ),
        colors = ButtonDefaults.buttonColors(
            containerColor = Color(0xFF7F56D9),
        )
    )
}


fun hexToColor(hexColorString: String): Color? {
    val sanitizedHex = hexColorString.removePrefix("#")

    if (sanitizedHex.length != 6) {
        return null
    }

    return try {
        val red = sanitizedHex.substring(0, 2).toInt(16)
        val green = sanitizedHex.substring(2, 4).toInt(16)
        val blue = sanitizedHex.substring(4, 6).toInt(16)
        Color(red, green, blue)
    } catch (e: NumberFormatException) {
        null
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SheetWidget(
    options: List<String>,
    selectedOption: String,
    onSelectionChange: (String) -> Unit
) {
    val sheetState = rememberModalBottomSheetState()
    var showSheet by remember { mutableStateOf(false) }
    Column {
        Box(
            modifier = Modifier
                .clickable {
                    showSheet = true
                }
                .fillMaxWidth()
                .padding(start = 4.dp, end = 4.dp, bottom = 4.dp)
                .border(
                    1.dp,
                    MaterialTheme.colorScheme.primary,
                    RoundedCornerShape(4.dp)
                )
                // Adjust padding based on whether the "border label" will be shown or not
                .padding(
                    horizontal = 16.dp,
                    vertical = 16.dp // Standard padding if no border label
                ),
            contentAlignment = Alignment.CenterStart
        ) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(
                    text = selectedOption,
                    style = MaterialTheme.typography.bodyLarge,
                    // color = Color.Black,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis
                )
            }
        }
    }
    if (showSheet) {
        ModalBottomSheet(
            modifier = Modifier.statusBarsPadding(),
            onDismissRequest = {
                showSheet = false
            },
            sheetState = sheetState,
            containerColor = Color.White,
            shape = RoundedCornerShape(14.dp),
        ) {
            // Apply safe area padding to the content
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp)
            ) {
                Row(
                    horizontalArrangement = Arrangement.SpaceBetween,
                    modifier = Modifier.fillMaxWidth()
                ) {
                    Text(
                        text = "Select Font Family",
                        style = MaterialTheme.typography.bodyLarge,
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis,
                        modifier = Modifier.weight(1f)
                    )

                    Spacer(modifier = Modifier.height(16.dp))

                    Spacer(modifier = Modifier.height(16.dp))

                    LazyColumn(
                        modifier = Modifier.fillMaxWidth()
                    ) {
                        items(options) { option ->
                            Row(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .clickable {
                                        onSelectionChange(option)
                                        showSheet = false
                                    }
                                    .padding(vertical = 16.dp, horizontal = 14.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Column(
                                    modifier = Modifier
                                        .weight(1f),
                                    verticalArrangement = Arrangement.Center
                                ) {
                                    Text(
                                        text = option,
                                        style = MaterialTheme.typography.bodyLarge,
                                    )

                                }
                                if (selectedOption == option) {
                                    Icon(
                                        imageVector = Icons.Default.Done,
                                        contentDescription = "Selected",
                                        tint = Color.Green
                                    )
                                }
                            }
                        }
                    }
                }
                Spacer(modifier = Modifier.height(16.dp))
            }
        }
    }
}