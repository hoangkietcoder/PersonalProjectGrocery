//plugins {
//    id "com.android.application"
//    id "kotlin-android"
//    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//    id "dev.flutter.flutter-gradle-plugin"
//}
//
//def localProperties = new Properties()
//def localPropertiesFile = rootProject.file("local.properties")
//if (localPropertiesFile.exists()) {
//    localPropertiesFile.withReader("UTF-8") { reader ->
//        localProperties.load(reader)
//    }
//}
//
//def flutterVersionCode = localProperties.getProperty("flutter.versionCode")
//if (flutterVersionCode == null) {
//    flutterVersionCode = "1"
//}
//
//def flutterVersionName = localProperties.getProperty("flutter.versionName")
//if (flutterVersionName == null) {
//    flutterVersionName = "1.0"
//}
//
//android {
//    namespace = "com.example.personalprojectgrocery"
//    compileSdk = 35
//    ndkVersion "25.2.9519653"
//
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_1_8
//        targetCompatibility = JavaVersion.VERSION_1_8
//    }
//
//    defaultConfig {
//        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//        applicationId = "com.example.personalprojectgrocery"
//        // You can update the following values to match your application needs.
//        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
//        minSdk = 23
//        targetSdk = 35
//        versionCode = 1
//        versionName "1.0"
//        multiDexEnabled true
//    }
//
//    buildTypes {
//        release {
//            // TODO: Add your own signing config for the release build.
//            // Signing with the debug keys for now, so `flutter run --release` works.
//            signingConfig = signingConfigs.debug
//            minifyEnabled true
//            shrinkResources true
//        }
//    }
//}
//
//flutter {
//    source = "../.."
//}
//
//dependencies {
//
//    // Import the Firebase BoM
//    implementation platform('com.google.firebase:firebase-bom:33.1.2')
//    // set up cho thông báo
//    implementation 'androidx.window:window:1.4.0'
//    implementation 'androidx.window:window-java:1.4.0'
//    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:2.1.5'
//
//}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.personalprojectgrocery"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.personalprojectgrocery"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {

    implementation(platform("com.google.firebase:firebase-bom:33.1.2"))
    implementation("androidx.window:window:1.4.0")
    implementation("androidx.window:window-java:1.4.0")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")

}
