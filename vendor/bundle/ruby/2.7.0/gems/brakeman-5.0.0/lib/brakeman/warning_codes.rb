module Brakeman::WarningCodes
  Codes = {
    :sql_injection => 0,
    :sql_injection_limit_offset => 1,
    :cross_site_scripting => 2,
    :xss_link_to => 3,
    :xss_link_to_href => 4,
    :xss_to_json => 5,
    :csrf_protection_disabled => 6,
    :csrf_protection_missing => 7,
    :csrf_blacklist => 8,
    :basic_auth_password => 9,
    :auth_blacklist => 10,
    :all_default_routes => 11,
    :controller_default_routes => 12,
    :code_eval => 13,
    :command_injection => 14,
    :dynamic_render_path => 15,
    :file_access => 16,
    :mass_assign_call => 17,
    :open_redirect => 18,
    :no_attr_accessible => 19,
    :attr_protected_used => 20,
    :safe_buffer_vuln => 21,
    :select_options_vuln => 22,
    :dangerous_send => 23,
    :unsafe_constantize => 24,
    :unsafe_deserialize => 25,
    :http_cookies => 26,
    :secure_cookies => 27,
    :translate_vuln => 28,
    :session_secret => 29,
    :validation_regex => 30,
    :CVE_2010_3933 => 31,
    :CVE_2011_0446 => 32,
    :CVE_2011_0447 => 33,
    :CVE_2011_2929 => 34,
    :CVE_2011_2930 => 35,
    :CVE_2011_2931 => 36,
    :CVE_2011_3186 => 37,
    :CVE_2012_2660 => 38,
    :CVE_2012_2661 => 39,
    :CVE_2012_2695 => 40,
    #:CVE_2012_2931 => 41,
    :CVE_2012_3424 => 42,
    :CVE_2012_3463 => 43,
    :CVE_2012_3464 => 44,
    :CVE_2012_3465 => 45,
    :CVE_2012_5664 => 46,
    :CVE_2013_0155 => 47,
    :CVE_2013_0156 => 48,
    :CVE_2013_0269 => 49,
    :CVE_2013_0277 => 50,
    :CVE_2013_0276 => 51,
    :CVE_2013_0333 => 52,
    :xss_content_tag => 53,
    :mass_assign_without_protection => 54,
    :CVE_2013_1854 => 55,
    :CVE_2013_1855 => 56,
    :CVE_2013_1856 => 57,
    :CVE_2013_1857 => 58,
    :unsafe_symbol_creation => 59,
    :dangerous_attr_accessible => 60,
    :local_request_config => 61,
    :detailed_exceptions => 62,
    :CVE_2013_4491 => 63,
    :CVE_2013_6414 => 64,
    # Replaced by CVE_2014_0081
    #:CVE_2013_6415 => 65,
    #:CVE_2013_6415_call => 66,
    :CVE_2013_6416 => 67,
    :CVE_2013_6416_call => 68,
    :CVE_2013_6417 => 69,
    :mass_assign_permit! => 70,
    :ssl_verification_bypass => 71,
    :CVE_2014_0080 => 72,
    :CVE_2014_0081 => 73,
    :CVE_2014_0081_call => 74,
    :CVE_2014_0082 => 75,
    :regex_dos => 76,
    :CVE_2014_0130 => 77,
    :CVE_2014_3482 => 78,
    :CVE_2014_3483 => 79,
    :CVE_2014_3514 => 80,
    :CVE_2014_3514_call => 81,
    :unscoped_find => 82,
    :CVE_2011_2932 => 83,
    :cross_site_scripting_inline => 84,
    :CVE_2014_7829 => 85,
    :csrf_not_protected_by_raising_exception => 86,
    :CVE_2015_3226 => 87,
    :CVE_2015_3227 => 88,
    :session_key_manipulation => 89,
    :weak_hash_digest => 90,
    :weak_hash_hmac => 91,
    :sql_injection_dynamic_finder => 92,
    :CVE_2015_7576 => 93,
    :CVE_2016_0751 => 94,
    :CVE_2015_7577 => 95,
    :CVE_2015_7578 => 96,
    :CVE_2015_7580 => 97,
    :CVE_2015_7579 => 98,
    :dynamic_render_path_rce => 99,
    :CVE_2015_7581 => 100,
    :secret_in_source => 101,
    :CVE_2016_6316 => 102,
    :CVE_2016_6317 => 103,
    :divide_by_zero => 104,
    :dangerous_permit_key => 105,
    :CVE_2018_8048 => 106,
    :CVE_2018_3741 => 107,
    :CVE_2018_3760 => 108,
    :force_ssl_disabled => 109,
    :unsafe_cookie_serialization => 110,
    :reverse_tabnabbing => 111,
    :mass_assign_permit_all => 112,
    :json_html_escape_config => 113,
    :json_html_escape_module => 114,
    :CVE_2020_8159 => 115,
    :CVE_2020_8166 => 116,
    :erb_template_injection => 117,
    :http_verb_confusion => 118,
    :unsafe_method_reflection => 119,

    :custom_check => 9090,
  }

  def self.code name
    Codes[name]
  end
end