module Ethon
  module Curl
    # :nodoc:
    VERSION_NOW = 3

    # Flag. Initialize SSL.
    GLOBAL_SSL     = 0x01
    # Flag. Initialize win32 socket libraries.
    GLOBAL_WIN32   = 0x02
    # Flag. Initialize everything possible.
    GLOBAL_ALL     = (GLOBAL_SSL | GLOBAL_WIN32)
    # Flag. Initialize everything by default.
    GLOBAL_DEFAULT = GLOBAL_ALL

    # :nodoc:
    EasyCode = enum(:easy_code, easy_codes)
    # :nodoc:
    MultiCode = enum(:multi_code, multi_codes)

    # :nodoc:
    EasyOption = enum(:easy_option, easy_options(:enum).to_a.flatten)
    # :nodoc:
    MultiOption = enum(:multi_option, multi_options(:enum).to_a.flatten)

    # Used by curl_debug_callback when setting CURLOPT_DEBUGFUNCTION
    # https://github.com/bagder/curl/blob/master/include/curl/curl.h#L378 for details
    DebugInfoType = enum(:debug_info_type, debug_info_types)

    # :nodoc:
    InfoType = enum(info_types.to_a.flatten)

    # Info details, refer
    # https://github.com/bagder/curl/blob/master/src/tool_writeout.c#L66 for details
    Info = enum(:info, infos.to_a.flatten)

    # Form options, used by FormAdd for temporary storage, refer
    # https://github.com/bagder/curl/blob/master/lib/formdata.h#L51 for details
    FormOption = enum(:form_option, form_options)

    # :nodoc:
    MsgCode = enum(:msg_code, msg_codes)
  end
end
