import 'package:flutter/foundation.dart';

//! production : local
const domain =
    kReleaseMode ? 'https://nestle-task-proof-server.zcoderz.com' : 'https://nestle-task-proof-server.zcoderz.com';
const apiUrl = '$domain/api/v1';
//! Auth
const loginUrl = '$apiUrl/users/auth/mobile/login';
const logoutUrl = '$apiUrl/users/auth/mobile/logout';
const registerUrl = '$apiUrl/users/auth/mobile/register';
const changePasswordUrl = '$apiUrl/users/password/mobile/change-password';
const changeEmailUrl = '$apiUrl/users/email/mobile/change-email';
const validateCodeEmailUrl = '$apiUrl/users/email/mobile/validate-email-otp';
const sendResetEmailCodeUrl = '$apiUrl/users/email/mobile/resend-change-email';
const undoChangeEmailUrl = '$apiUrl/users/email/mobile/undo-change-email';
const resetPasswordUrl = '$apiUrl/users/password/reset-password-link';
const forgetPasswordPageUrl = "https://nestle-task-proof.zcoderz.com/change-password";
const changePhoneNumberUrl = "$apiUrl/users/phone/mobile/change-phone";
const getCountryCodeUrl = "$apiUrl/api-utils/country-code/mobile";
// company
const joinCompanyUrl = '$apiUrl/companies/join-requests/mobile/';
const cancelJoinRequestUrl = '$apiUrl/companies/join-requests/mobile/cancel_joining';
const companyProfileUrl = '$apiUrl/companies/companies/mobile/company-profile';
///////tasks
const tasksUrl = "$apiUrl/task-proof/tasks/mobile/";
const getStoresUrl = '$apiUrl/task-proof/tasks/mobile/get-store-names';

const profileUrl = '$apiUrl/profiles/profiles/mobile/user-profile';
const profileImageUrl = '$apiUrl/users/profile-image';
//privacy policy
const privacyPolicyUrl = "$apiUrl/policy/privacy_policy/mobile/";
//FAQ
const faqUrl = '$apiUrl/faqs/faqs/mobile/';
//? image full url

String getMediaUrl(String path) => '$domain$path';
String getLocationInfoUrl(double longtitude, double latitude) =>
    'https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longtitude&format=json';
