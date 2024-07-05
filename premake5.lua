
cpr_dep_libs = {}
curl_lib_folder = ""

project "cpr"
	kind "StaticLib"
	language "C++"
    staticruntime "off"

	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	defines
	{
		"CURL_STATICLIB"
	}


	if (os.target() == "windows") 
	then

		cpr_dep_libs = 
		{
			"libcurl",
			"Normaliz",
			"Ws2_32",
			"Wldap32",
			"Crypt32",
			"advapi32"
		}

		curl_lib_folder = "%{prj.location}/" .. "vendor/curl/lib/Windows"

	elseif (os.target() == "linux")
	then
		cpr_dep_libs = 
		{
			"curl",
			"z",
			"ssl",
			"crypto"
		}

		curl_lib_folder = "%{prj.location}/" .. "vendor/curl/lib/Linux"

	end

	includedirs
	{
		"include",
		"vendor/curl/include"
	}

	files
	{
		"./cpr/*.cpp"
	}

	libdirs
	{
		curl_lib_folder
	}

	links
	{
		cpr_dep_libs
	}


	filter "system:windows"
		systemversion "latest"
		cppdialect "C++latest"
		

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++latest"

	
	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
        symbols "off"
