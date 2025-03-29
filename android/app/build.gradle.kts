plugins {
    id("com.android.application")
    // Apply the Google services plugin (version comes from the root declaration)
    id("com.google.gms.google-services")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

dependencies {
    // Import the Firebase BoM to manage Firebase dependency versions.
    implementation(platform("com.google.firebase:firebase-bom:33.11.0"))
    // Add additional Firebase dependencies here (without specifying versions)
}

android {
    namespace = "com.example.zoom_clone"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"  // Fixed: required NDK version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.zoom_clone"
        minSdk = 23  // Fixed: minimum SDK version required by Firebase Auth
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // For release, use your own signing config if available.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
