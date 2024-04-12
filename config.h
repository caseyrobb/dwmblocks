//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		              /*Update Interval*/	/*Update Signal*/
	{"",	"~/.local/bin/wifi.sh",         30, 	              1},
	{"",	"~/.local/bin/packages.sh",     600,	              1},
	{"",	"~/.local/bin/forecast.sh",	    600,	              2},
	{"",	"~/.local/bin/volume.sh",	      1,	                3},
	{"",	"~/.local/bin/redshift.sh",     1,	                4},
	{"",	"~/.local/bin/calendar.sh",	    60,	                6},
	{"",	"~/.local/bin/battery.sh",	    5,	                5},
};

//Sets delimiter between status commands. NULL character ('\0') means no delimiter.
//static char *delim = "";
static char *delim = " | ";
