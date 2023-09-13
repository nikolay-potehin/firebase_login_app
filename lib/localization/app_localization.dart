import 'package:firebase_login_app/localization/localization_keys.dart';
import 'package:flutter/material.dart';

export 'package:firebase_login_app/localization/localization_keys.dart';

extension LocalizationExtensions on BuildContext {
  String localize(LocKeys value) {
    final code = AppLocalization.of(this)?.locale.languageCode ?? "en";
    const database = AppLocalization._localizedValues;
    const placeholder = AppLocalization._placeholder;

    if (database.containsKey(code)) {
      return database[code]?[value] ?? placeholder;
    } else {
      return database["en"]?[value] ?? placeholder;
    }
  }
}

class AppLocalization {
  final Locale locale;
  const AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) =>
      Localizations.of<AppLocalization>(context, AppLocalization);

  static const _placeholder = "-";

  static const Map<String, Map<LocKeys, String>> _localizedValues = {
    "en": {
      // Utils
      LocKeys.yes: "Yes",
      LocKeys.no: "No",
      LocKeys.onAppExitWarning: "You sure you want to exit app?",

      // Errors
      // Authenticating
      LocKeys.onErrorDefault: "Error occured, please try again later",
      LocKeys.onUserNotFoundError: "Sorry, such user was not found",
      LocKeys.onNetworkRequestFailed:
          "Couldn't connect to the server. Please, check your internet connection",
      LocKeys.onRequiresRecentLogin:
          "For this operation, please authenticate first",
      LocKeys.onEmailAlreadyInUse:
          "This email is already in use. Please, try a different email",
      LocKeys.onWrongPassword: "Incorrect password. Please try again",

      // Sending messages
      LocKeys.onSuchUserDoesntExist: "Sorry, such user doesn't exist",

      // Form Validation
      LocKeys.onEmptyEmailError: "Email cannot be empty",
      LocKeys.onInvalidEmailError: "Email adress is badly formatted",
      LocKeys.onEmptyPasswordError: "Password cannot be empty",
      LocKeys.onPasswordTooShortError: "Password should be at least 6 symbols",
      LocKeys.onPasswordsDontMatchError: "Passwords do not match",
      LocKeys.onEmptyFieldError: "Field cannot be empty",

      // Messages
      LocKeys.resetPasswordEmailHasBeenSentSuccessfully:
          "Email with password reset has been send successfully",
      LocKeys.messageSentSuccessfully: "Message sent successfully",

      // Months
      LocKeys.monthJan: "Jan",
      LocKeys.monthFeb: "Feb",
      LocKeys.monthMar: "Mar",
      LocKeys.monthApr: "Apr",
      LocKeys.monthMay: "May",
      LocKeys.monthJun: "Jun",
      LocKeys.monthJul: "Jul",
      LocKeys.monthAug: "Aug",
      LocKeys.monthSep: "Sep",
      LocKeys.monthOct: "Oct",
      LocKeys.monthNov: "Nov",
      LocKeys.monthDec: "Dec",

      // Login Page
      LocKeys.welcomeBack: "Welcome Back",
      LocKeys.signInToContinue: "Sign In to continue",
      LocKeys.dontHaveAccount: "Don't have account?",
      LocKeys.goRegister: "Create a new account",
      LocKeys.email: "Email",
      LocKeys.password: "Password",
      LocKeys.forgotPassword: "Forgot password?",
      LocKeys.loginBtn: "Login",

      // Forgot Password Page
      LocKeys.resetPasswordTitle: "Reset Password",
      LocKeys.receiveEmailToResetPassword:
          "Receive an email to reset your password",
      LocKeys.resetPassword: "Reset Password",

      // Register Page
      LocKeys.createAccountTitle: "Create Account",
      LocKeys.createAccountSubtitle: "Create New Account",
      LocKeys.name: "Name",
      LocKeys.confirmPassword: "Confirm Password",
      LocKeys.registerBtn: "Create Account",
      LocKeys.goLogin: "Login",
      LocKeys.alreadyAUser: "Already a user?",

      // Email Verification Page
      LocKeys.emailVerification: "Email Verification",
      LocKeys.aVerificationEmailHasBeenSentToYourEmail:
          "A verification email has been sent to your email",
      LocKeys.cancelRegistration: "Cancel registration process",
      LocKeys.cancelRegistrationWarning:
          "You sure you want to cancel registration process?",
      LocKeys.cancel: "Cancel",

      // Home Page
      // Empty Folder Widget
      LocKeys.yourFolderIs: "Your",
      LocKeys.folderIsEmpty: "folder is empty",

      // Filter Drawer
      LocKeys.sended: "Sended",
      LocKeys.received: "Received",
      LocKeys.unread: "Unread",
      LocKeys.greenBox: "Green Box",

      // Inbox Page
      LocKeys.from: "From",
      LocKeys.to: "To",
      LocKeys.selected: "Selected",
      LocKeys.inbox: "Inbox",
      LocKeys.deleteSelectedMessages: "Delete selected messages?",
      LocKeys.deleteSelectedMessagesWarning:
          "You are about to delete all selected messages. Are you sure?",

      // Users Page
      LocKeys.users: "Users",

      // Account Page
      LocKeys.account: "Account",
      LocKeys.createdAt: "Created at",
      LocKeys.pickAvatar: "Pick Avatar",
      LocKeys.logout: "Log out",
      LocKeys.logoutWarning: "You sure you want to log out?",

      // Message Page
      LocKeys.message: "Message",
      LocKeys.deleteThisMessageWarning: "Delete this message?",

      // Expandable Message Info Card
      LocKeys.date: "Date",

      // Write Message Page
      LocKeys.newMessage: "New Message",
      LocKeys.messageTopic: "Topic",
      LocKeys.messageTopicHint: "Message topic",
      LocKeys.messageContent: "Content",
      LocKeys.messageContentHint: "Message content",
    },
    "ru": {
      // Utils
      LocKeys.yes: "Да",
      LocKeys.no: "Нет",
      LocKeys.onAppExitWarning: "Вы уверены, что хотите выйти из приложения?",

      // Errors
      // Authenticating
      LocKeys.onErrorDefault: "Произошла ошибка. Пожалуйста, попробуйте позже",
      LocKeys.onUserNotFoundError:
          "Такого пользователя не существует. Пожалуйста, попробуйте ввести другие данные",
      LocKeys.onNetworkRequestFailed:
          "Не получилось подключиться к серверу. Пожалуйста, проверьте ваше интернет соединение",
      LocKeys.onRequiresRecentLogin:
          "Для выполнения этой операции, пожалуйста, авторизуйтесь",
      LocKeys.onEmailAlreadyInUse:
          "Этот электронный адрес уже занят. Пожалуйста, попробуйте другую почту",
      LocKeys.onWrongPassword:
          'Неверный пароль. Если вы забыли пароль, нажмите на соответствующую кнопку',

      // Sending messages
      LocKeys.onSuchUserDoesntExist:
          "Извините, такого пользователя не существует",

      // Form Validation
      LocKeys.onEmptyEmailError: "Почта не может быть пустой",
      LocKeys.onInvalidEmailError: "Укажите верный адрес почты",
      LocKeys.onEmptyPasswordError: "Пароль не может быть пустым",
      LocKeys.onPasswordTooShortError: "Пароль слишком короткий",
      LocKeys.onPasswordsDontMatchError: "Пароли не совпадают",
      LocKeys.onEmptyFieldError: "Это поле не может быть пустым",

      // Messages
      LocKeys.resetPasswordEmailHasBeenSentSuccessfully:
          "Письмо с инструкциями для сброса пароля было отправлено на вашу почту",
      LocKeys.messageSentSuccessfully: "Письмо успешно отправлено",

      // Months
      LocKeys.monthJan: "Янв",
      LocKeys.monthFeb: "Фев",
      LocKeys.monthMar: "Мар",
      LocKeys.monthApr: "Апр",
      LocKeys.monthMay: "Мая",
      LocKeys.monthJun: "Июн",
      LocKeys.monthJul: "Июл",
      LocKeys.monthAug: "Авг",
      LocKeys.monthSep: "Сен",
      LocKeys.monthOct: "Окт",
      LocKeys.monthNov: "Ноя",
      LocKeys.monthDec: "Дек",

      // Login Page
      LocKeys.welcomeBack: "Добро Пожаловать",
      LocKeys.signInToContinue: "Войдите, чтобы продолжить",
      LocKeys.dontHaveAccount: "Нет аккаунта?",
      LocKeys.goRegister: "Создать аккаунт",
      LocKeys.email: "Электронная почта",
      LocKeys.password: "Пароль",
      LocKeys.forgotPassword: "Забыли пароль?",
      LocKeys.loginBtn: "Войти",

      // Forgot Password Page
      LocKeys.resetPasswordTitle: "Сброс Пароля",
      LocKeys.receiveEmailToResetPassword:
          "Получите письмо, чтобы сбросить пароль",
      LocKeys.resetPassword: "Отправить письмо",

      // Register Page
      LocKeys.createAccountTitle: "Создайте аккаунт",
      LocKeys.createAccountSubtitle: "Создать новый аккаунт",
      LocKeys.name: "Имя",
      LocKeys.confirmPassword: "Подтвердите пароль",
      LocKeys.registerBtn: "Создать аккаунт",
      LocKeys.goLogin: "Войти",
      LocKeys.alreadyAUser: "Уже есть аккаунт?",

      // Email Verification Page
      LocKeys.emailVerification: "Подтверждение почты",
      LocKeys.aVerificationEmailHasBeenSentToYourEmail:
          "На вашу почту было отправлено письмо с подтверждением регистрации",
      LocKeys.cancelRegistration: "Отменить регистрацию",
      LocKeys.cancelRegistrationWarning:
          "Вы уверены, что хотите отменить регистрацию аккаунта?",
      LocKeys.cancel: "Отменить",

      // Home Page
      // Empty Folder Widget
      LocKeys.yourFolderIs: "Ваша папка",
      LocKeys.folderIsEmpty: "пуста",

      // Filter Drawer
      LocKeys.sended: "Отправленные",
      LocKeys.received: "Полученные",
      LocKeys.unread: "Непрочитанные",
      LocKeys.greenBox: "Green Box",

      // Inbox Page
      LocKeys.from: "От",
      LocKeys.to: "Кому",
      LocKeys.selected: "Выбранные",
      LocKeys.inbox: "Ваша Почта",
      LocKeys.deleteSelectedMessages: "Удалить выбранные письма?",
      LocKeys.deleteSelectedMessagesWarning:
          "Вы собираетесь удалить все выбранные письма. Вы уверены?",

      // Users Page
      LocKeys.users: "Пользователи",

      // Account Page
      LocKeys.account: "Аккаунт",
      LocKeys.createdAt: "Создан",
      LocKeys.pickAvatar: "Выберите изображение",
      LocKeys.logout: "Выйти",
      LocKeys.logoutWarning: "Выйти из аккаунта?",

      // Message Page
      LocKeys.message: "Письмо",
      LocKeys.deleteThisMessageWarning: "Удалить это письмо?",

      // Expandable Message Info Card
      LocKeys.date: "Дата",

      // Write Message Page
      LocKeys.newMessage: "Новое письмо",
      LocKeys.messageTopic: "Тема",
      LocKeys.messageTopicHint: "Тема письма",
      LocKeys.messageContent: "Содержание",
      LocKeys.messageContentHint: "Содержание письма",
    }
  };
}
