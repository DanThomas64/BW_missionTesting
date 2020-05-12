#include "..\core\script_bad.hpp"
#define COMPONENT MAINMENU
#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE
#define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_MODE_FULL
    #define UITOOLTIP(CTRLCREATE,IDC) CTRLCREATE ctrlSetTooltip IDC
#else
    #define UITOOLTIP(CTRLCREATE,IDC)
#endif
#include "..\core\script_macros.hpp"

#define RECOMPILE

/* #define MAINMENU 0
#define SECONDMENU 1
 */
