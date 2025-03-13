import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryService {
  static final SentryService _instance = SentryService._internal();

  factory SentryService() {
    return _instance;
  }

  SentryService._internal();

  bool _isInitialized = false;

  Future<void> init({
    required String dsn,
    String environment = 'production',
    String? release,
    double tracesSampleRate = 0.1, // Adjust in production
    bool debug = kDebugMode,
  }) async {
    if (_isInitialized) {
      return; // Prevent multiple initializations
    }

    await SentryFlutter.init(
          (options) {
        options.dsn = dsn;
        options.environment = environment;
        options.release = release;
        options.tracesSampleRate = tracesSampleRate;
        options.debug = debug;
        // Add other options as needed (e.g., integrations, beforeSend callback)
      },
    );
    _isInitialized = true;
  }

  Future<void> captureException(
      dynamic exception, {
        dynamic stackTrace,
        String? message,
        Map<String, dynamic>? extra,
        Breadcrumb? breadcrumb,
        SentryLevel? level = SentryLevel.error,
      }) async {
    if (!_isInitialized) {
      if (kDebugMode) {
        print('Sentry not initialized. Exception: $exception'); // Log in debug
      }
      return;
    }

    // Create the event and capture the exception
    try {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error capturing exception in Sentry: $e');
      }
    }

    // Add the breadcrumb if provided
    if (breadcrumb != null) {
      try {
        await Sentry.addBreadcrumb(breadcrumb);
      } catch (e) {
        if (kDebugMode) {
          print('Error adding breadcrumb: $e');
        }
      }
    }
  }

  Future<void> captureMessage(String message, {SentryLevel? level}) async {
    if (!_isInitialized) {
      if (kDebugMode) {
        print('Sentry not initialized. Message: $message'); // Log in debug
      }
      return;
    }
    await Sentry.captureMessage(message, level: level);
  }

  Future<void> addBreadcrumb(Breadcrumb breadcrumb) async {
    if (!_isInitialized) {
      return;
    }
    await Sentry.addBreadcrumb(breadcrumb);
  }

  Hub get currentHub => Sentry.currentHub;
}

