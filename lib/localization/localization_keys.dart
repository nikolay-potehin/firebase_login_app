import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_app/models/inbox_model.dart';

extension FirebaseExceptionExtensions on FirebaseException {
  LocKeys toLocKey() {
    print(code);
    switch (code) {
      case 'user-not-found':
        return LocKeys.onUserNotFoundError;
      case 'invalid-email':
        return LocKeys.onInvalidEmailError;
      case 'network-request-failed':
        return LocKeys.onNetworkRequestFailed;
      case 'email-already-in-use':
        return LocKeys.onEmailAlreadyInUse;
      case 'wrong-password':
        return LocKeys.onWrongPassword;
      default:
        return LocKeys.onErrorDefault;
    }
  }
}

extension LocalizationExtensions on Messages {
  LocKeys toLocKey() {
    switch (this) {
      case Messages.received:
        return LocKeys.received;
      case Messages.sended:
        return LocKeys.sended;
      case Messages.unread:
        return LocKeys.unread;
    }
  }
}

enum LocKeys {
  // Utils
  yes,
  no,
  onAppExitWarning,

  // Errors
  // Authenticating
  onErrorDefault,
  onUserNotFoundError,
  onNetworkRequestFailed,
  onEmailAlreadyInUse,
  onWrongPassword,

  // Sending messages
  onSuchUserDoesntExist,

  // Form Validation
  onEmptyEmailError,
  onInvalidEmailError,
  onEmptyPasswordError,
  onPasswordTooShortError,
  onPasswordsDontMatchError,
  onEmptyFieldError,

  // Messages
  resetPasswordEmailHasBeenSentSuccessfully,
  messageSentSuccessfully,

  // Months
  monthJan,
  monthFeb,
  monthMar,
  monthApr,
  monthMay,
  monthJun,
  monthJul,
  monthAug,
  monthSep,
  monthOct,
  monthNov,
  monthDec,

  // Pages
  // Login Page
  welcomeBack,
  signInToContinue,
  dontHaveAccount,
  goRegister,
  email,
  password,
  forgotPassword,
  loginBtn,

  // Forgot Password Page
  resetPasswordTitle,
  receiveEmailToResetPassword,
  resetPassword,

  // Register Page
  createAccountTitle,
  createAccountSubtitle,
  name,
  confirmPassword,
  registerBtn,
  goLogin,
  alreadyAUser,

  // Email Verification Page
  emailVerification,
  aVerificationEmailHasBeenSentToYourEmail,
  cancelAndLogout,
  cancelAndLogoutWarning,
  cancel,

  // Home Page
  // Empty Folder Widget
  yourFolderIs,
  folderIsEmpty,

  // Filter Drawer
  sended,
  received,
  unread,
  greenBox,

  // Inbox Page
  from,
  to,
  selected,
  inbox,
  deleteSelectedMessages,
  deleteSelectedMessagesWarning,

  // Users Page
  users,

  // Account Page
  account,
  createdAt,
  pickAvatar,
  logout,
  logoutWarning,

  // Message Page
  message,
  deleteThisMessageWarning,

  // Expandable Message Info Card
  date,

  // Write Message Page
  newMessage,
  messageTopic,
  messageTopicHint,
  messageContent,
  messageContentHint,
}
