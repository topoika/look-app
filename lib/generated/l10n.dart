// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter Your Phone Number`
  String get enter_your_phone_number {
    return Intl.message(
      'Enter Your Phone Number',
      name: 'enter_your_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Continue to get Confirmation code to your number`
  String get continue_to_get_confirmation_code {
    return Intl.message(
      'Continue to get Confirmation code to your number',
      name: 'continue_to_get_confirmation_code',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct 10 digits of mobile number`
  String get please_enter_a_correct_phone_number {
    return Intl.message(
      'Please enter correct 10 digits of mobile number',
      name: 'please_enter_a_correct_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `OTP can't be less than 6 characters`
  String get otp_cant_be_less_than_six_characters {
    return Intl.message(
      'OTP can\'t be less than 6 characters',
      name: 'otp_cant_be_less_than_six_characters',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `I don't get the code`
  String get i_did_not_get_the_code {
    return Intl.message(
      'I don\'t get the code',
      name: 'i_did_not_get_the_code',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_text {
    return Intl.message(
      'Continue',
      name: 'continue_text',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Code`
  String get enter_your_code {
    return Intl.message(
      'Enter Your Code',
      name: 'enter_your_code',
      desc: '',
      args: [],
    );
  }

  /// `To use look, you should read and agree to the terms of use`
  String get to_use_look_you_must_read_and_agree_to_the_terms_of_user {
    return Intl.message(
      'To use look, you should read and agree to the terms of use',
      name: 'to_use_look_you_must_read_and_agree_to_the_terms_of_user',
      desc: '',
      args: [],
    );
  }

  /// `Location Based Service Terms`
  String get location_based_service_terms {
    return Intl.message(
      'Location Based Service Terms',
      name: 'location_based_service_terms',
      desc: '',
      args: [],
    );
  }

  /// `Terms Of Use`
  String get terms_of_use {
    return Intl.message(
      'Terms Of Use',
      name: 'terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information Handling Methods`
  String get personal_information_handling_methods {
    return Intl.message(
      'Personal Information Handling Methods',
      name: 'personal_information_handling_methods',
      desc: '',
      args: [],
    );
  }

  /// `I agree with above personal handling information`
  String get i_agree_with_above_personal_handling_information {
    return Intl.message(
      'I agree with above personal handling information',
      name: 'i_agree_with_above_personal_handling_information',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Look`
  String get welcome_to_look {
    return Intl.message(
      'Welcome to Look',
      name: 'welcome_to_look',
      desc: '',
      args: [],
    );
  }

  /// `Improve your profile to get more attention`
  String get improve_your_profile_to_get_more_attention {
    return Intl.message(
      'Improve your profile to get more attention',
      name: 'improve_your_profile_to_get_more_attention',
      desc: '',
      args: [],
    );
  }

  /// `Women`
  String get women {
    return Intl.message(
      'Women',
      name: 'women',
      desc: '',
      args: [],
    );
  }

  /// `Men`
  String get men {
    return Intl.message(
      'Men',
      name: 'men',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get username {
    return Intl.message(
      'User Name',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Register the correct birthday to enjoy more and more fun`
  String get register_the_correct_birthday_to_enjoy_more_and_more_fun {
    return Intl.message(
      'Register the correct birthday to enjoy more and more fun',
      name: 'register_the_correct_birthday_to_enjoy_more_and_more_fun',
      desc: '',
      args: [],
    );
  }

  /// `Marital Status`
  String get martitual_status {
    return Intl.message(
      'Marital Status',
      name: 'martitual_status',
      desc: '',
      args: [],
    );
  }

  /// `Single`
  String get single {
    return Intl.message(
      'Single',
      name: 'single',
      desc: '',
      args: [],
    );
  }

  /// `Single Mom`
  String get single_mom {
    return Intl.message(
      'Single Mom',
      name: 'single_mom',
      desc: '',
      args: [],
    );
  }

  /// `Single Dad`
  String get single_dad {
    return Intl.message(
      'Single Dad',
      name: 'single_dad',
      desc: '',
      args: [],
    );
  }

  /// `In a Relationship`
  String get in_a_relationship {
    return Intl.message(
      'In a Relationship',
      name: 'in_a_relationship',
      desc: '',
      args: [],
    );
  }

  /// `Married`
  String get married {
    return Intl.message(
      'Married',
      name: 'married',
      desc: '',
      args: [],
    );
  }

  /// `Separated`
  String get separated {
    return Intl.message(
      'Separated',
      name: 'separated',
      desc: '',
      args: [],
    );
  }

  /// `Devorced`
  String get devorced {
    return Intl.message(
      'Devorced',
      name: 'devorced',
      desc: '',
      args: [],
    );
  }

  /// `Widowed`
  String get widowed {
    return Intl.message(
      'Widowed',
      name: 'widowed',
      desc: '',
      args: [],
    );
  }

  /// `What is Your Education`
  String get what_is_your_education {
    return Intl.message(
      'What is Your Education',
      name: 'what_is_your_education',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `High School`
  String get high_school {
    return Intl.message(
      'High School',
      name: 'high_school',
      desc: '',
      args: [],
    );
  }

  /// `College`
  String get college {
    return Intl.message(
      'College',
      name: 'college',
      desc: '',
      args: [],
    );
  }

  /// `Bachelor Degree`
  String get bachelor_degree {
    return Intl.message(
      'Bachelor Degree',
      name: 'bachelor_degree',
      desc: '',
      args: [],
    );
  }

  /// `Post Graduate`
  String get post_graduate {
    return Intl.message(
      'Post Graduate',
      name: 'post_graduate',
      desc: '',
      args: [],
    );
  }

  /// `Masters`
  String get masters {
    return Intl.message(
      'Masters',
      name: 'masters',
      desc: '',
      args: [],
    );
  }

  /// `Phd/Doctorate`
  String get phd {
    return Intl.message(
      'Phd/Doctorate',
      name: 'phd',
      desc: '',
      args: [],
    );
  }

  /// `Post Doctorate`
  String get post_doctorate {
    return Intl.message(
      'Post Doctorate',
      name: 'post_doctorate',
      desc: '',
      args: [],
    );
  }

  /// `Drinking`
  String get drinking {
    return Intl.message(
      'Drinking',
      name: 'drinking',
      desc: '',
      args: [],
    );
  }

  /// `Smoking`
  String get smoking {
    return Intl.message(
      'Smoking',
      name: 'smoking',
      desc: '',
      args: [],
    );
  }

  /// `Eating`
  String get eating {
    return Intl.message(
      'Eating',
      name: 'eating',
      desc: '',
      args: [],
    );
  }

  /// `Non Drinker`
  String get non_drinker {
    return Intl.message(
      'Non Drinker',
      name: 'non_drinker',
      desc: '',
      args: [],
    );
  }

  /// `Social Drinker`
  String get social_drinker {
    return Intl.message(
      'Social Drinker',
      name: 'social_drinker',
      desc: '',
      args: [],
    );
  }

  /// `Heavy Drinker`
  String get heavy_drinker {
    return Intl.message(
      'Heavy Drinker',
      name: 'heavy_drinker',
      desc: '',
      args: [],
    );
  }

  /// `Non Smoker`
  String get non_smoker {
    return Intl.message(
      'Non Smoker',
      name: 'non_smoker',
      desc: '',
      args: [],
    );
  }

  /// `Lighter Smoker`
  String get lighter_smoker {
    return Intl.message(
      'Lighter Smoker',
      name: 'lighter_smoker',
      desc: '',
      args: [],
    );
  }

  /// `Heavy Smoker`
  String get heavy_smoker {
    return Intl.message(
      'Heavy Smoker',
      name: 'heavy_smoker',
      desc: '',
      args: [],
    );
  }

  /// `Vegan`
  String get vegan {
    return Intl.message(
      'Vegan',
      name: 'vegan',
      desc: '',
      args: [],
    );
  }

  /// `Vegeterian`
  String get vegeterian {
    return Intl.message(
      'Vegeterian',
      name: 'vegeterian',
      desc: '',
      args: [],
    );
  }

  /// `Personality`
  String get personality {
    return Intl.message(
      'Personality',
      name: 'personality',
      desc: '',
      args: [],
    );
  }

  /// `Funny`
  String get funny {
    return Intl.message(
      'Funny',
      name: 'funny',
      desc: '',
      args: [],
    );
  }

  /// `Romantic`
  String get romantic {
    return Intl.message(
      'Romantic',
      name: 'romantic',
      desc: '',
      args: [],
    );
  }

  /// `Open Minded`
  String get open_minded {
    return Intl.message(
      'Open Minded',
      name: 'open_minded',
      desc: '',
      args: [],
    );
  }

  /// `Interests`
  String get interests {
    return Intl.message(
      'Interests',
      name: 'interests',
      desc: '',
      args: [],
    );
  }

  /// `Dancing`
  String get dancing {
    return Intl.message(
      'Dancing',
      name: 'dancing',
      desc: '',
      args: [],
    );
  }

  /// `Hiking`
  String get hiking {
    return Intl.message(
      'Hiking',
      name: 'hiking',
      desc: '',
      args: [],
    );
  }

  /// `Singing`
  String get singing {
    return Intl.message(
      'Singing',
      name: 'singing',
      desc: '',
      args: [],
    );
  }

  /// `Reading`
  String get reading {
    return Intl.message(
      'Reading',
      name: 'reading',
      desc: '',
      args: [],
    );
  }

  /// `Fishing`
  String get fishing {
    return Intl.message(
      'Fishing',
      name: 'fishing',
      desc: '',
      args: [],
    );
  }

  /// `Travel`
  String get travel {
    return Intl.message(
      'Travel',
      name: 'travel',
      desc: '',
      args: [],
    );
  }

  /// `Fitness`
  String get fitness {
    return Intl.message(
      'Fitness',
      name: 'fitness',
      desc: '',
      args: [],
    );
  }

  /// `Photography`
  String get photography {
    return Intl.message(
      'Photography',
      name: 'photography',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get music {
    return Intl.message(
      'Music',
      name: 'music',
      desc: '',
      args: [],
    );
  }

  /// `Movie`
  String get movie {
    return Intl.message(
      'Movie',
      name: 'movie',
      desc: '',
      args: [],
    );
  }

  /// `Camping`
  String get camping {
    return Intl.message(
      'Camping',
      name: 'camping',
      desc: '',
      args: [],
    );
  }

  /// `Sports`
  String get sports {
    return Intl.message(
      'Sports',
      name: 'sports',
      desc: '',
      args: [],
    );
  }

  /// `Lives In`
  String get lives_in {
    return Intl.message(
      'Lives In',
      name: 'lives_in',
      desc: '',
      args: [],
    );
  }

  /// `Enter Current Location`
  String get enter_current_location {
    return Intl.message(
      'Enter Current Location',
      name: 'enter_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Get Current Location`
  String get get_current_location {
    return Intl.message(
      'Get Current Location',
      name: 'get_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Input your job`
  String get input_your_job {
    return Intl.message(
      'Input your job',
      name: 'input_your_job',
      desc: '',
      args: [],
    );
  }

  /// `Describe yourself`
  String get describe_yourself {
    return Intl.message(
      'Describe yourself',
      name: 'describe_yourself',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection`
  String get check_internet_connection {
    return Intl.message(
      'Check your internet connection',
      name: 'check_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Live Streaming`
  String get live_streaming {
    return Intl.message(
      'Live Streaming',
      name: 'live_streaming',
      desc: '',
      args: [],
    );
  }

  /// `Grid`
  String get grid {
    return Intl.message(
      'Grid',
      name: 'grid',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get list {
    return Intl.message(
      'List',
      name: 'list',
      desc: '',
      args: [],
    );
  }

  /// `Video Call`
  String get video_call {
    return Intl.message(
      'Video Call',
      name: 'video_call',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get points {
    return Intl.message(
      'Points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `Call History`
  String get call_history {
    return Intl.message(
      'Call History',
      name: 'call_history',
      desc: '',
      args: [],
    );
  }

  /// `Public Notice`
  String get public_notice {
    return Intl.message(
      'Public Notice',
      name: 'public_notice',
      desc: '',
      args: [],
    );
  }

  /// `Inquiry`
  String get inquiry {
    return Intl.message(
      'Inquiry',
      name: 'inquiry',
      desc: '',
      args: [],
    );
  }

  /// `My Invitee`
  String get my_invitee {
    return Intl.message(
      'My Invitee',
      name: 'my_invitee',
      desc: '',
      args: [],
    );
  }

  /// `Coin Store`
  String get coin_store {
    return Intl.message(
      'Coin Store',
      name: 'coin_store',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get log_out {
    return Intl.message(
      'Log Out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Recharge`
  String get recharge {
    return Intl.message(
      'Recharge',
      name: 'recharge',
      desc: '',
      args: [],
    );
  }

  /// `My Info`
  String get my_info {
    return Intl.message(
      'My Info',
      name: 'my_info',
      desc: '',
      args: [],
    );
  }

  /// `Go Live`
  String get go_live {
    return Intl.message(
      'Go Live',
      name: 'go_live',
      desc: '',
      args: [],
    );
  }

  /// `End Live`
  String get end_live {
    return Intl.message(
      'End Live',
      name: 'end_live',
      desc: '',
      args: [],
    );
  }

  /// `Leave Live`
  String get leave_live {
    return Intl.message(
      'Leave Live',
      name: 'leave_live',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Type Message`
  String get type_message {
    return Intl.message(
      'Type Message',
      name: 'type_message',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Search Username`
  String get search_username {
    return Intl.message(
      'Search Username',
      name: 'search_username',
      desc: '',
      args: [],
    );
  }

  /// `Add content`
  String get add_content {
    return Intl.message(
      'Add content',
      name: 'add_content',
      desc: '',
      args: [],
    );
  }

  /// `Self Introduction`
  String get self_introduction {
    return Intl.message(
      'Self Introduction',
      name: 'self_introduction',
      desc: '',
      args: [],
    );
  }

  /// `Job title`
  String get job_title {
    return Intl.message(
      'Job title',
      name: 'job_title',
      desc: '',
      args: [],
    );
  }

  /// `Available Points`
  String get available_points {
    return Intl.message(
      'Available Points',
      name: 'available_points',
      desc: '',
      args: [],
    );
  }

  /// `Points Setting`
  String get points_setting {
    return Intl.message(
      'Points Setting',
      name: 'points_setting',
      desc: '',
      args: [],
    );
  }

  /// `Redeem Points`
  String get redeem_points {
    return Intl.message(
      'Redeem Points',
      name: 'redeem_points',
      desc: '',
      args: [],
    );
  }

  /// `Transaction History`
  String get transaction_history {
    return Intl.message(
      'Transaction History',
      name: 'transaction_history',
      desc: '',
      args: [],
    );
  }

  /// `Free Recharge`
  String get free_recharge {
    return Intl.message(
      'Free Recharge',
      name: 'free_recharge',
      desc: '',
      args: [],
    );
  }

  /// `Daily Task`
  String get daily_task {
    return Intl.message(
      'Daily Task',
      name: 'daily_task',
      desc: '',
      args: [],
    );
  }

  /// `My Points`
  String get my_points {
    return Intl.message(
      'My Points',
      name: 'my_points',
      desc: '',
      args: [],
    );
  }

  /// `Points Recharge`
  String get points_recharge {
    return Intl.message(
      'Points Recharge',
      name: 'points_recharge',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get date_of_birth {
    return Intl.message(
      'Date of Birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Recieved Gifts`
  String get recieved_gifts {
    return Intl.message(
      'Recieved Gifts',
      name: 'recieved_gifts',
      desc: '',
      args: [],
    );
  }

  /// `km Away`
  String get km_away {
    return Intl.message(
      'km Away',
      name: 'km_away',
      desc: '',
      args: [],
    );
  }

  /// `Searching for a User`
  String get searching_for_a_user {
    return Intl.message(
      'Searching for a User',
      name: 'searching_for_a_user',
      desc: '',
      args: [],
    );
  }

  /// `My Interests`
  String get modify_interest {
    return Intl.message(
      'My Interests',
      name: 'modify_interest',
      desc: '',
      args: [],
    );
  }

  /// `No Data Found`
  String get no_data_found {
    return Intl.message(
      'No Data Found',
      name: 'no_data_found',
      desc: '',
      args: [],
    );
  }

  /// `Smart photo`
  String get smart_photo {
    return Intl.message(
      'Smart photo',
      name: 'smart_photo',
      desc: '',
      args: [],
    );
  }

  /// `Input your interests`
  String get input_your_interests {
    return Intl.message(
      'Input your interests',
      name: 'input_your_interests',
      desc: '',
      args: [],
    );
  }

  /// `Enter your current job`
  String get enter_your_current_job {
    return Intl.message(
      'Enter your current job',
      name: 'enter_your_current_job',
      desc: '',
      args: [],
    );
  }

  /// `Enter you email`
  String get enter_your_email {
    return Intl.message(
      'Enter you email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save_text {
    return Intl.message(
      'Save',
      name: 'save_text',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid location`
  String get please_enter_a_valid_location {
    return Intl.message(
      'Please enter a valid location',
      name: 'please_enter_a_valid_location',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid job title`
  String get please_enter_a_valid_job {
    return Intl.message(
      'Please enter a valid job title',
      name: 'please_enter_a_valid_job',
      desc: '',
      args: [],
    );
  }

  /// `Type atleast 10+ characters`
  String get type_atleast_ten_characters {
    return Intl.message(
      'Type atleast 10+ characters',
      name: 'type_atleast_ten_characters',
      desc: '',
      args: [],
    );
  }

  /// `Type a comment`
  String get type_a_comment {
    return Intl.message(
      'Type a comment',
      name: 'type_a_comment',
      desc: '',
      args: [],
    );
  }

  /// `Connecting`
  String get connecting {
    return Intl.message(
      'Connecting',
      name: 'connecting',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Big Event`
  String get big_event {
    return Intl.message(
      'Big Event',
      name: 'big_event',
      desc: '',
      args: [],
    );
  }

  /// `points Collected, visit tomorrow to have more`
  String get points_collected_visit_tomorrow_to_have_more {
    return Intl.message(
      'points Collected, visit tomorrow to have more',
      name: 'points_collected_visit_tomorrow_to_have_more',
      desc: '',
      args: [],
    );
  }

  /// `Make video call with`
  String get make_video_call_with {
    return Intl.message(
      'Make video call with',
      name: 'make_video_call_with',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get join {
    return Intl.message(
      'Join',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to exit`
  String get do_you_want_to_exit {
    return Intl.message(
      'Do you want to exit',
      name: 'do_you_want_to_exit',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure`
  String get are_you_sure {
    return Intl.message(
      'Are you sure',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes_text {
    return Intl.message(
      'Yes',
      name: 'yes_text',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no_text {
    return Intl.message(
      'No',
      name: 'no_text',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get discard {
    return Intl.message(
      'Discard',
      name: 'discard',
      desc: '',
      args: [],
    );
  }

  /// `Searching for new Friends`
  String get searching_for_user {
    return Intl.message(
      'Searching for new Friends',
      name: 'searching_for_user',
      desc: '',
      args: [],
    );
  }

  /// `Error while generating token, Please try again`
  String get error_while_generating_token_please_try_again {
    return Intl.message(
      'Error while generating token, Please try again',
      name: 'error_while_generating_token_please_try_again',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get min_text {
    return Intl.message(
      'min',
      name: 'min_text',
      desc: '',
      args: [],
    );
  }

  /// `sms`
  String get sns_text {
    return Intl.message(
      'sms',
      name: 'sns_text',
      desc: '',
      args: [],
    );
  }

  /// `Gift`
  String get gift_text {
    return Intl.message(
      'Gift',
      name: 'gift_text',
      desc: '',
      args: [],
    );
  }

  /// `Calling`
  String get calling_text {
    return Intl.message(
      'Calling',
      name: 'calling_text',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get terms_and_contitions {
    return Intl.message(
      'Terms and Conditions',
      name: 'terms_and_contitions',
      desc: '',
      args: [],
    );
  }

  /// `These are the Terms and Conditions or our app`
  String get these_are_the_terms_and_conditions_or_our_app {
    return Intl.message(
      'These are the Terms and Conditions or our app',
      name: 'these_are_the_terms_and_conditions_or_our_app',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel_text {
    return Intl.message(
      'Cancel',
      name: 'cancel_text',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok_text {
    return Intl.message(
      'Ok',
      name: 'ok_text',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm_text {
    return Intl.message(
      'Confirm',
      name: 'confirm_text',
      desc: '',
      args: [],
    );
  }

  /// `Enter name of 5+ characters`
  String get enter_name_of_five_plus_characters {
    return Intl.message(
      'Enter name of 5+ characters',
      name: 'enter_name_of_five_plus_characters',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the depositor name`
  String get please_enter_the_depositor_name {
    return Intl.message(
      'Please enter the depositor name',
      name: 'please_enter_the_depositor_name',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done_text {
    return Intl.message(
      'Done',
      name: 'done_text',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing_text {
    return Intl.message(
      'Processing',
      name: 'processing_text',
      desc: '',
      args: [],
    );
  }

  /// `Payment successful`
  String get payment_successful {
    return Intl.message(
      'Payment successful',
      name: 'payment_successful',
      desc: '',
      args: [],
    );
  }

  /// `Points credited`
  String get points_credited {
    return Intl.message(
      'Points credited',
      name: 'points_credited',
      desc: '',
      args: [],
    );
  }

  /// `Your name livestream`
  String get your_name_livestream {
    return Intl.message(
      'Your name livestream',
      name: 'your_name_livestream',
      desc: '',
      args: [],
    );
  }

  /// `Edit your video and sms rate`
  String get edit_your_video_and_sms_rate {
    return Intl.message(
      'Edit your video and sms rate',
      name: 'edit_your_video_and_sms_rate',
      desc: '',
      args: [],
    );
  }

  /// `Enter the title of your liveStream`
  String get enter_the_title_of_your_liveStream {
    return Intl.message(
      'Enter the title of your liveStream',
      name: 'enter_the_title_of_your_liveStream',
      desc: '',
      args: [],
    );
  }

  /// `Enter 3+ char for the title`
  String get enter_three_plus_char_for_the_title {
    return Intl.message(
      'Enter 3+ char for the title',
      name: 'enter_three_plus_char_for_the_title',
      desc: '',
      args: [],
    );
  }

  /// `Video rate`
  String get video_rate {
    return Intl.message(
      'Video rate',
      name: 'video_rate',
      desc: '',
      args: [],
    );
  }

  /// `Sms rate`
  String get sms_rate {
    return Intl.message(
      'Sms rate',
      name: 'sms_rate',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language_text {
    return Intl.message(
      'Language',
      name: 'language_text',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message_text {
    return Intl.message(
      'Message',
      name: 'message_text',
      desc: '',
      args: [],
    );
  }

  /// `New Match`
  String get new_match {
    return Intl.message(
      'New Match',
      name: 'new_match',
      desc: '',
      args: [],
    );
  }

  /// `Push Notifications`
  String get push_notifications {
    return Intl.message(
      'Push Notifications',
      name: 'push_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Block List`
  String get block_list {
    return Intl.message(
      'Block List',
      name: 'block_list',
      desc: '',
      args: [],
    );
  }

  /// `Age range of partners`
  String get age_range_of_partners {
    return Intl.message(
      'Age range of partners',
      name: 'age_range_of_partners',
      desc: '',
      args: [],
    );
  }

  /// `Global mode`
  String get global_mode {
    return Intl.message(
      'Global mode',
      name: 'global_mode',
      desc: '',
      args: [],
    );
  }

  /// `Change your location and meet other local people`
  String get change_your_location_and_meet_other_local_people {
    return Intl.message(
      'Change your location and meet other local people',
      name: 'change_your_location_and_meet_other_local_people',
      desc: '',
      args: [],
    );
  }

  /// `new location addition`
  String get new_loction_addition {
    return Intl.message(
      'new location addition',
      name: 'new_loction_addition',
      desc: '',
      args: [],
    );
  }

  /// `my current location`
  String get my_current_location {
    return Intl.message(
      'my current location',
      name: 'my_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Social discovery range setting`
  String get social_discovery_range_setting {
    return Intl.message(
      'Social discovery range setting',
      name: 'social_discovery_range_setting',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_text {
    return Intl.message(
      'Settings',
      name: 'settings_text',
      desc: '',
      args: [],
    );
  }

  /// `Maximum distance from partners`
  String get max_distance_of_partners {
    return Intl.message(
      'Maximum distance from partners',
      name: 'max_distance_of_partners',
      desc: '',
      args: [],
    );
  }

  /// `You are available online video call now waiting for others`
  String get you_are_availble_online_video_call_now_waiting {
    return Intl.message(
      'You are available online video call now waiting for others',
      name: 'you_are_availble_online_video_call_now_waiting',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note_text {
    return Intl.message(
      'Note',
      name: 'note_text',
      desc: '',
      args: [],
    );
  }

  /// `It is allowed to upload any ponographic text or image content. If violations are verified, the corporation will stop it directly and the earnings will be not settled`
  String get not_allowed_to_upload_any_ponographic {
    return Intl.message(
      'It is allowed to upload any ponographic text or image content. If violations are verified, the corporation will stop it directly and the earnings will be not settled',
      name: 'not_allowed_to_upload_any_ponographic',
      desc: '',
      args: [],
    );
  }

  /// `Google play in app bottomsheet,try BIG EVENT`
  String get google_play_in_app_bottomsheet_try {
    return Intl.message(
      'Google play in app bottomsheet,try BIG EVENT',
      name: 'google_play_in_app_bottomsheet_try',
      desc: '',
      args: [],
    );
  }

  /// `Payment Amount`
  String get payment_mount {
    return Intl.message(
      'Payment Amount',
      name: 'payment_mount',
      desc: '',
      args: [],
    );
  }

  /// `Purchase point`
  String get purchase_point {
    return Intl.message(
      'Purchase point',
      name: 'purchase_point',
      desc: '',
      args: [],
    );
  }

  /// `Copied to clipboard`
  String get copied_to_clipboard {
    return Intl.message(
      'Copied to clipboard',
      name: 'copied_to_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `Copying bank account number`
  String get copying_bank_account_number {
    return Intl.message(
      'Copying bank account number',
      name: 'copying_bank_account_number',
      desc: '',
      args: [],
    );
  }

  /// `Depositor Name`
  String get depositor_name {
    return Intl.message(
      'Depositor Name',
      name: 'depositor_name',
      desc: '',
      args: [],
    );
  }

  /// `Account Holder`
  String get account_holder {
    return Intl.message(
      'Account Holder',
      name: 'account_holder',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter the depositor name. If you do not deposit the correct amount or if the depositor name is different, the point charging may be delayed`
  String get if_you_do_not_deposit_the_correct_amount {
    return Intl.message(
      'Please Enter the depositor name. If you do not deposit the correct amount or if the depositor name is different, the point charging may be delayed',
      name: 'if_you_do_not_deposit_the_correct_amount',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account Deposit`
  String get bank_account_deposit {
    return Intl.message(
      'Bank Account Deposit',
      name: 'bank_account_deposit',
      desc: '',
      args: [],
    );
  }

  /// `You have already collected points for today come back tommorow for more`
  String
      get you_have_already_collected_points_for_today_come_back_tommorow_for_more {
    return Intl.message(
      'You have already collected points for today come back tommorow for more',
      name:
          'you_have_already_collected_points_for_today_come_back_tommorow_for_more',
      desc: '',
      args: [],
    );
  }

  /// `VIP Subscription Plan`
  String get vip_ubscription_plan {
    return Intl.message(
      'VIP Subscription Plan',
      name: 'vip_ubscription_plan',
      desc: '',
      args: [],
    );
  }

  /// `Public notice for today is really cool and you gonna love it`
  String get public_notice_for_today_is_really_cool_and_you_gonna_love_it {
    return Intl.message(
      'Public notice for today is really cool and you gonna love it',
      name: 'public_notice_for_today_is_really_cool_and_you_gonna_love_it',
      desc: '',
      args: [],
    );
  }

  /// `recharge or earning`
  String get recharge_or_rearning {
    return Intl.message(
      'recharge or earning',
      name: 'recharge_or_rearning',
      desc: '',
      args: [],
    );
  }

  /// `using or redeem`
  String get using_or_redeem {
    return Intl.message(
      'using or redeem',
      name: 'using_or_redeem',
      desc: '',
      args: [],
    );
  }

  /// `balance`
  String get balance_text {
    return Intl.message(
      'balance',
      name: 'balance_text',
      desc: '',
      args: [],
    );
  }

  /// `created`
  String get created_text {
    return Intl.message(
      'created',
      name: 'created_text',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name_text {
    return Intl.message(
      'name',
      name: 'name_text',
      desc: '',
      args: [],
    );
  }

  /// `time`
  String get time_text {
    return Intl.message(
      'time',
      name: 'time_text',
      desc: '',
      args: [],
    );
  }

  /// `point`
  String get point_text {
    return Intl.message(
      'point',
      name: 'point_text',
      desc: '',
      args: [],
    );
  }

  /// `full name`
  String get full_name {
    return Intl.message(
      'full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `gender`
  String get gender_text {
    return Intl.message(
      'gender',
      name: 'gender_text',
      desc: '',
      args: [],
    );
  }

  /// `age`
  String get age_text {
    return Intl.message(
      'age',
      name: 'age_text',
      desc: '',
      args: [],
    );
  }

  /// `location`
  String get location_text {
    return Intl.message(
      'location',
      name: 'location_text',
      desc: '',
      args: [],
    );
  }

  /// `Ask any question and admin will respond immediatelly`
  String get ask_any_question_and_admin_will_respond_immediatelly {
    return Intl.message(
      'Ask any question and admin will respond immediatelly',
      name: 'ask_any_question_and_admin_will_respond_immediatelly',
      desc: '',
      args: [],
    );
  }

  /// `What can I help you`
  String get what_can_i_help_you {
    return Intl.message(
      'What can I help you',
      name: 'what_can_i_help_you',
      desc: '',
      args: [],
    );
  }

  /// `Point to be refund`
  String get point_to_be_refund {
    return Intl.message(
      'Point to be refund',
      name: 'point_to_be_refund',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get bank_text {
    return Intl.message(
      'Bank',
      name: 'bank_text',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account_text {
    return Intl.message(
      'Account',
      name: 'account_text',
      desc: '',
      args: [],
    );
  }

  /// `Depositor`
  String get depositor_text {
    return Intl.message(
      'Depositor',
      name: 'depositor_text',
      desc: '',
      args: [],
    );
  }

  /// `Notice`
  String get notice_text {
    return Intl.message(
      'Notice',
      name: 'notice_text',
      desc: '',
      args: [],
    );
  }

  /// `The minimum redeem point is`
  String get the_minimum_redeem_point_is {
    return Intl.message(
      'The minimum redeem point is',
      name: 'the_minimum_redeem_point_is',
      desc: '',
      args: [],
    );
  }

  /// `We deduct`
  String get we_deduct {
    return Intl.message(
      'We deduct',
      name: 'we_deduct',
      desc: '',
      args: [],
    );
  }

  /// `deposit fee and`
  String get deposit_fee_and {
    return Intl.message(
      'deposit fee and',
      name: 'deposit_fee_and',
      desc: '',
      args: [],
    );
  }

  /// `VAT.`
  String get vat_text {
    return Intl.message(
      'VAT.',
      name: 'vat_text',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city_text {
    return Intl.message(
      'City',
      name: 'city_text',
      desc: '',
      args: [],
    );
  }

  /// `Call ended`
  String get call_ended {
    return Intl.message(
      'Call ended',
      name: 'call_ended',
      desc: '',
      args: [],
    );
  }

  /// `Please wait`
  String get please_wait {
    return Intl.message(
      'Please wait',
      name: 'please_wait',
      desc: '',
      args: [],
    );
  }

  /// `Verify your internet connection`
  String get verify_your_internet_connection {
    return Intl.message(
      'Verify your internet connection',
      name: 'verify_your_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `There are not enough you have`
  String get there_are_not_enough_you_have {
    return Intl.message(
      'There are not enough you have',
      name: 'there_are_not_enough_you_have',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
