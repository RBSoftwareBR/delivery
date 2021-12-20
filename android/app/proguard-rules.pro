#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class com.dexterous.** { *; }
-dontwarn io.card.**
-dontwarn **.**
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}